from rest_framework import viewsets
from rest_framework.decorators import detail_route
from rest_framework.response import Response
from converter.models import ConverterBBoxJob
from converter.serializers import ConverterBBoxJobSerializer
from converters.osm_cutter import BBox
from manager.job_manager import ConversionJobManager


class ConverterBBoxJobViewSet(viewsets.ModelViewSet):
    """
    This viewset automatically provides `list` and `detail` actions.
    """
    queryset = ConverterBBoxJob.objects.all()
    serializer_class = ConverterBBoxJobSerializer

    @detail_route(methods=['get'])
    def start_conversion(self, request, *args, **kwargs):
        bbox_job = self.get_object()
        conversion_job = ConversionJobManager(geometry=BBox(*bbox_job.cut_out_area.extent))
        conversion_job.start_conversion()
        return Response('')


"""
{
        "type": "Polygon",
        "coordinates": [
            [
                [
                    100.0,
                    0.0
                ],
                [
                    100.1,
                    0.0
                ],
                [
                    100.1,
                    0.1
                ],
                [
                    100.0,
                    0.1
                ],
                [
                    100.0,
                    0.0
                ]
            ]
        ]
    }
"""