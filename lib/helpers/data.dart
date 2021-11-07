import 'package:architectapp/models/category_model.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Journal Articles";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "News Articles";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Book Chapters";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Conference Reports";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Books";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "https://www.elegantthemes.com/blog/wp-content/uploads/2021/01/online-business-ideas-featured-image-scaled.jpg";
  category.add(categoryModel);

  return category;
}