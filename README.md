# Multimodal Image Retrieval System (MATLAB)
**Author:** Arman Azadi
**Institution:** Iran University of Science and Technology (IUST)

## 📌 Project Overview
This project implements a **Dual-Mode Image Retrieval System** capable of retrieving images from a database using either visual content or semantic metadata. It features two distinct search engines:

1.  **Content-Based Image Retrieval (CBIR):** Finds similar images based on color distribution.
2.  **Text-Based Image Retrieval (TBIR):** Finds images based on associated tags and descriptions.

## 🔬 Methodology

### 1. Visual Search Engine (CBIR)
The visual search module quantifies "similarity" between a query image and database images using color features.
* **Feature Extraction:** Images are converted from RGB to **HSV color space** to separate chromatic content from intensity. A quantized color histogram is extracted as the feature vector.
* **Similarity Metric:** The system uses the **Bhattacharyya Distance** to measure the overlap between two normalized histograms ($H_1, H_2$):
    $$D_B(H_1, H_2) = \sqrt{1 - \sum_{i} \sqrt{H_1(i) \cdot H_2(i)}}$$
    This metric is statistically more robust for comparing probability distributions than Euclidean distance.

### 2. Semantic Search Engine (TBIR)
The text search module allows users to query the dataset using natural language keywords.
* **Data Source:** Uses `image_metadata.csv` containing filenames and descriptive tags.
* **Algorithm:** Implements string pattern matching to filter and rank images that contain the query terms in their metadata.

## 📂 File Structure
* `main_visual_search.m`: Main script for running the CBIR engine.
* `main_text_search.m`: Main script for running the TBIR engine.
* `extract_hsv_features.m`: Helper function for HSV quantization and histogram generation.
* `bhattacharyya.m`: Mathematical function for computing histogram distance.
* `image_metadata.csv`: Database catalog mapping filenames to tags.
* `custom_dataset.zip`: The custom dataset with DB folder

## 🚀 Usage

## 🚀 Usage

### Prerequisites
1.  **MATLAB** (R2018b or later recommended).
2.  **Dataset Setup:**
    * Download and extract `custom_dataset.zip`.
    * **Important:** Rename the extracted folder to **`DB`** and place it in the root directory of the project.
    * Ensure the structure is:
        ```
        /multimodal-image-retrieval-matlab
        ├── main_visual_search.m
        ├── ...
        └── DB/
            ├── nokia_1100_black_1.jpg
            ├── ...
        ```

### Running the Visual Search (CBIR)
1.  Open `main_visual_search.m`.
2.  Run the script.
3.  A dialog will open asking you to select a query image.
4.  The system will calculate HSV histograms and display the top matches based on Bhattacharyya distance.

### Running the Text Search (TBIR)
1.  Open `main_text_search.m`.
2.  Run the script.
3.  Enter a keyword when prompted (e.g., "apple", "nokia").
4.  The system will list all image files that match the metadata tags.
