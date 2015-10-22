from django.contrib.contenttypes.fields import GenericForeignKey, GenericRelation
from django.contrib.contenttypes.models import ContentType
from django.contrib.gis.db import models
from django.utils.translation import ugettext_lazy as _
from django_enumfield import enum

from converters import converter_options


class ConversionStatus(enum.Enum):
    RECEIVED = 0
    QUEUED = 1
    STARTED = 2
    SUCCESSFUL = 10
    ERROR = 12
    labels = {
        RECEIVED: 'received',
        QUEUED: 'queued',
        STARTED: 'started',
        ERROR: 'error',
        SUCCESSFUL: 'success',
    }
    # These transitions state that a ConversionStatus can only go to
    # ERROR from RECEIVED, QUEUED, STARTED,
    # to QUEUED from RECEIVED,
    # to SUCCESSFUL from .
    _transitions = {
        ERROR: (RECEIVED, QUEUED, STARTED),
        QUEUED: (RECEIVED, ),
        SUCCESSFUL: (STARTED, ),
    }


class ConversionFormatStatus(models.Model):
    object_id = models.PositiveIntegerField()
    content_type = models.ForeignKey(ContentType)
    job = GenericForeignKey('content_type', 'object_id')
    format = models.CharField(
        _('conversion format'),
        choices=( (o,o) for o in converter_options.get_output_formats()),
        max_length=200,
    )
    status = models.IntegerField('status', choices=ConversionStatus.choices())


# class ConverterPolyfileJob(models.Model):
#     polyfile = models.FileField(_('polyfile'), )
#     formats = GenericRelation(ConversionFormatStatus, related_query_name='polyfile_jobs')
#
#     @property
#     def overall_status(self):
#         return min([conversion_format.status for conversion_format in self.formats])


class ConverterBBoxJob(models.Model):
    cut_out_area = models.PolygonField(_('area'), )
    formats = GenericRelation(ConversionFormatStatus, related_query_name='box_jobs')

    @property
    def overall_status(self):
        return min([conversion_format.status for conversion_format in self.formats])
