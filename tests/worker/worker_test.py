# pylint: disable=C0111
from collections import namedtuple
from unittest import mock

from django.test import TestCase
from django_rq import get_connection
from rest_framework.reverse import reverse
from rq.job import Job

from converters.boundaries import BBox
from converters.converter import Options
from converters.gis_converter.extract.excerpt import Excerpt
from manager.rq_helper import rq_enqueue_with_settings
from shared import ConversionProgress
from worker.converter_job import convert, set_progress_on_job
from tests.redis_test_helpers import perform_all_jobs_sync


class WorkerTest(TestCase):
    pbf_file_path = '/some_path/to/pbf.pbf'

    @mock.patch('os.remove')
    @mock.patch.object(Excerpt, '_copy_statistics_file_to_format_dir', return_value=None)
    @mock.patch.object(Excerpt, '_get_statistics', return_value=None)
    @mock.patch.object(Excerpt, '_export_from_db_to_format', return_value=None)
    @mock.patch('converters.gis_converter.bootstrap.bootstrap.boostrap', return_value=None)
    @mock.patch('converters.osm_cutter.cut_osm_extent', return_value=pbf_file_path)
    def test_convert_calls_cut_osm_extent_and_bootstrap(self, cut_osm_extent_mock, bootstrap_mock, *args, **kwargs):  # pylint: disable=W0613
        geometry = BBox(29.525547623634335, 40.77546776498174, 29.528980851173397, 40.77739734768811)
        format_options = Options(output_formats=['fgdb', 'spatialite', 'shp', 'gpkg'])
        convert(geometry=geometry, format_options=format_options, callback_url=None, output_directory='/tmp/')
        cut_osm_extent_mock.assert_called_once_with(geometry)
        bootstrap_mock.assert_called_once_with(self.pbf_file_path)

    def test_set_progress_on_job_sets_the_progress(self):
        job = rq_enqueue_with_settings(set_progress_on_job, ConversionProgress.SUCCESSFUL)
        perform_all_jobs_sync()
        job_fetched = Job.fetch(job.id, connection=get_connection())
        self.assertDictEqual(job_fetched.meta, {'progress': ConversionProgress.SUCCESSFUL})


def do_nothing_callable():
    pass


class ConvertTest(TestCase):
    pbf_file_path = '/some_path/to/pbf.pbf'
    mocked_job_id = '0' * 36
    rq_job_stub = namedtuple('RQJob', ['id', 'meta', 'save'])(
        id=mocked_job_id,
        meta={'progress': ''},
        save=do_nothing_callable,
    )

    @mock.patch('os.remove')
    @mock.patch.object(Excerpt, '_copy_statistics_file_to_format_dir', return_value=None)
    @mock.patch.object(Excerpt, '_get_statistics', return_value=None)
    @mock.patch.object(Excerpt, '_export_from_db_to_format', return_value=None)
    @mock.patch('converters.gis_converter.bootstrap.bootstrap.boostrap', return_value=None)
    @mock.patch('converters.osm_cutter.cut_osm_extent', return_value=pbf_file_path)
    @mock.patch('rq.get_current_job', return_value=rq_job_stub)
    @mock.patch('worker.converter_job.Notifier')
    def test_convert_with_host_and_job_assembles_url_correctly(self, notifier_mock, rq_job_stub, *args, **kwargs):
        format_options = Options(output_formats=['fgdb', 'spatialite', 'shp', 'gpkg'])
        geometry, output_directory, callback_url = None, '/tmp/', None
        host = 'http://converter-host.example.com'
        convert(geometry, format_options, output_directory, callback_url, host)
        expected_url = host + reverse(viewname='gisformat-detail', kwargs={'pk': self.mocked_job_id})
        notifier_mock.assert_called_with(callback_url, expected_url)
