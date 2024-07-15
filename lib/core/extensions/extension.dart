import 'package:flutter/material.dart';
import 'package:tm_school/assets/colors.dart';
import 'package:tm_school/assets/fonts.dart';
import 'package:tm_school/assets/icons.dart';
import 'package:tm_school/assets/images.dart';
import 'package:tm_school/assets/theme.dart';
import 'package:tm_school/core/route_names/route_name.dart';
import 'package:tm_school/features/dashboard/data/model/models.dart';
import 'package:tm_school/features/dashboard/domain/entity/entity.dart';

extension BuildContextGeneral on BuildContext {
  AppColors get colors {
    return AppColors();
  }

  AppTheme get theme {
    return AppTheme();
  }

  AppFonts get style {
    return theme.darkTheme().extension<AppFonts>()!;
  }

  AppIcons get icon {
    return AppIcons();
  }

  AppImages get image {
    return AppImages();
  }

  AppRouteName get route {
    return AppRouteName();
  }
}

extension NewsModelToNewsEntity on NewsModel {
  NewsEntity get toEntity {
    return NewsEntity(
      data: data.map((e) => e.toEntity).toList(),
      groupDate: groupDate,
    );
  }
}

extension DatumTODatumEntity on MiniNewsModel {
  DatumEntity get toEntity {
    return DatumEntity(
      id: id,
      title: title,
      description: description,
      status: status,
      images: images,
      createdTime: createdTime,
    );
  }
}

extension CourseModelToCourseEntity on CourseModel {
  CoursesEntity get toEntity {
    return CoursesEntity(
      id: id,
      name: name,
      createdAt: createdAt,
      lessonsCount: lessonsCount,
      images: images,
      lessonTitle: lessonTitle,
      percentage: percentage,
    );
  }
}
