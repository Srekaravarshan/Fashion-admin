import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion/config/paths.dart';
import 'package:fashion/models/models.dart';
import 'package:fashion/repositories/repositories.dart';
import 'package:fashion/screens/category/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  // StreamSubscription<List<CategoryItem?>>? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryState.initial());

  // @override
  // Future<void> close() {
  //   _categorySubscription?.cancel();
  //   return super.close();
  // }

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    // if (event is LoadCategory) {
    //   yield* _mapLoadCategoryUserToState(event);
    // } else
    if (event is AddCategory) {
      yield* _mapAddCategoryUserToState(event);
    } else if (event is UpdateCategories) {
      yield* _mapUpdateCategoryUserToState(event);
    } else if (event is AddStack) {
      yield* _mapAddStackUserToState(event);
    }
  }

  // Stream<CategoryState> _mapLoadCategoryUserToState(LoadCategory event) async* {
  //   yield state.copyWith(status: CategoryStatus.loading);
  //   try {
  //     // final categories = await _categoryRepository.getCategoryItems(
  //     //     reference: event.reference);
  //     _categorySubscription?.cancel();
  //     _categorySubscription = _categoryRepository
  //         .getCategoryItems(reference: event.reference)
  //         .listen((categories) {
  //       final allCategories = categories;
  //       add(UpdateCategories(categories: allCategories));
  //     });
  //     yield state.copyWith(status: CategoryStatus.loaded);
  //   } catch (err) {
  //     yield state.copyWith(
  //         status: CategoryStatus.error,
  //         failure: Failure(message: 'Something went wrong' + err.toString()));
  //   }
  // }

  Stream<CategoryState> _mapUpdateCategoryUserToState(
      UpdateCategories event) async* {
    yield state.copyWith(categories: event.categories);
  }

  Stream<CategoryState> _mapAddCategoryUserToState(AddCategory event) async* {
    try {
      await _categoryRepository.createCategoryItem(
          item: CategoryItem(
              title: event.category,
              isCategory: event.isCategory,
              reference: event.reference,
              products: []),
          reference: event.reference);
    } catch (err) {
      yield state.copyWith(
          status: CategoryStatus.error,
          failure: Failure(message: 'Something went wrong' + err.toString()));
    }
  }

  Stream<CategoryState> _mapAddStackUserToState(AddStack event) async* {
    try {
      Stream<List<CategoryItem?>> categories =
          _categoryRepository.getCategoryItems(reference: event.reference);

      yield state.copyWith(
          categoryStacks: state.addCategoryStack(categories, event.context),
          index: state.index + 1,
          reference: event.reference);
    } catch (err) {
      yield state.copyWith(
          status: CategoryStatus.error,
          failure: Failure(message: 'Something went wrong ' + err.toString()));
    }
  }
}
