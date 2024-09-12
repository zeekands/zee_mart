import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zee_mart/core/theme/colors/const_colors.dart';
import 'package:zee_mart/data/models/category_model.dart';
import 'package:zee_mart/data/models/product_model.dart';
import 'package:zee_mart/presentation/blocs/cubit/create_product_cubit.dart';
import 'package:zee_mart/presentation/blocs/cubit/get_category_cubit.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<GetCategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Product'),
        backgroundColor: kMainColor, // Adjust color to match Shopee's theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Product Name',
                hint: 'Enter product name',
              ),
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              BlocConsumer<GetCategoryCubit, GetCategoryState>(
                listener: (context, state) {
                  state.maybeWhen(
                    error: (failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to load categories: $failure'),
                        ),
                      );
                    },
                    loaded: (categories) {
                      if (_selectedCategory == null) {
                        setState(() {
                          _selectedCategory = categories.first;
                        });
                      }
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.when(
                    initial: () => Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    ),
                    loading: () => Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    ),
                    loaded: (categories) {
                      return DropdownButtonFormField<CategoryModel>(
                        menuMaxHeight: 400,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[300],
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          hintText: 'Select category',
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 1.5,
                            ),
                          ),
                        ),
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        items: categories.map((category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Text(category.category),
                          );
                        }).toList(),
                      );
                    },
                    error: (failure) => const Text('Failed to load categories'),
                  );
                },
              ),
              _buildTextField(
                controller: _skuController,
                label: 'SKU',
                hint: 'Enter SKU',
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Enter description',
                maxLines: 3,
              ),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (g)',
                hint: 'Enter weight in grams',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _widthController,
                label: 'Width (cm)',
                hint: 'Enter width in cm',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
                hint: 'Enter height in cm',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _lengthController,
                label: 'Length (cm)',
                hint: 'Enter length in cm',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _imageController,
                label: 'Image URL',
                hint: 'Enter image URL',
              ),
              _buildTextField(
                controller: _priceController,
                label: 'Price',
                hint: 'Enter price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<CreateProductCubit, CreateProductState>(
            listener: (context, state) {
              state.maybeWhen(
                error: (failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create product: $failure'),
                    ),
                  );
                },
                loaded: (product) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product created: ${product.name}', style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop(true);
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final data = ProductModel(
                        name: _nameController.text,
                        categoryId: _selectedCategory?.id ?? 0,
                        categoryName: _selectedCategory?.category ?? '',
                        sku: _skuController.text,
                        description: _descriptionController.text,
                        weight: double.parse(_weightController.text),
                        width: double.parse(_widthController.text),
                        height: double.parse(_heightController.text),
                        length: double.parse(_lengthController.text),
                        image: _imageController.text,
                        price: double.parse(_priceController.text),
                      );

                      context.read<CreateProductCubit>().createProduct(data);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Create Product', style: TextStyle(fontSize: 14, color: kMainWhite)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.orange,
                  width: 1.5,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
