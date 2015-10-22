# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django_enumfield.enum
import converter.models
import django.contrib.gis.db.models.fields


class Migration(migrations.Migration):

    dependencies = [
        ('contenttypes', '0002_remove_content_type_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='ConversionFormatStatus',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('object_id', models.PositiveIntegerField()),
                ('format', models.CharField(max_length=200, choices=[('fgdb', 'fgdb'), ('shp', 'shp'), ('gpkg', 'gpkg'), ('spatialite', 'spatialite')], verbose_name='conversion format')),
                ('status', models.IntegerField(choices=[(0, django_enumfield.enum.Value('RECEIVED', 0, 'received', converter.models.ConversionStatus)), (1, django_enumfield.enum.Value('QUEUED', 1, 'queued', converter.models.ConversionStatus)), (2, django_enumfield.enum.Value('STARTED', 2, 'started', converter.models.ConversionStatus)), (10, django_enumfield.enum.Value('SUCCESSFUL', 10, 'success', converter.models.ConversionStatus)), (12, django_enumfield.enum.Value('ERROR', 12, 'error', converter.models.ConversionStatus))], verbose_name='status')),
                ('content_type', models.ForeignKey(to='contenttypes.ContentType')),
            ],
        ),
        migrations.CreateModel(
            name='ConverterBBoxJob',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('cut_out_area', django.contrib.gis.db.models.fields.PolygonField(srid=4326, verbose_name='area')),
            ],
        ),
        migrations.CreateModel(
            name='ConverterPolyfileJob',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('polyfile', models.FileField(verbose_name='polyfile', upload_to='')),
            ],
        ),
    ]
