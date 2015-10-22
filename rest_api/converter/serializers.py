from rest_framework import serializers
from rest_framework_gis.serializers import GeoFeatureModelSerializer
from converter.models import ConverterBBoxJob


class ConverterBBoxJobSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        geo_field = 'cut_out_area'
        model = ConverterBBoxJob