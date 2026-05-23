import os
from PIL import Image

def optimize_banner():
    input_path = r"c:\Flutter project\good_dream\assets\images\sounds_banner.png"
    output_path = r"c:\Flutter project\good_dream\assets\images\sounds_banner.webp"
    
    if not os.path.exists(input_path):
        print(f"Error: File {input_path} not found.")
        return
        
    print(f"Opening original image: {input_path}")
    img = Image.open(input_path)
    original_size_bytes = os.path.getsize(input_path)
    print(f"Original size: {img.size} ({original_size_bytes / 1024:.1f} KB)")
    
    # 1. Widescreen Crop (e.g., 2.5:1 ratio)
    # We crop a beautiful horizontal slice that captures the moon and forest tops
    # Assuming square aspect ratio (e.g., 1024x1024), we crop from y=100 to y=600 (height 500)
    width, height = img.size
    
    # Smart horizontal crop (keeping it centered horizontally, and cropping vertically)
    # Let's crop from 10% to 65% of height to capture the moon and trees
    crop_top = int(height * 0.05)
    crop_bottom = int(height * 0.60)
    cropped_img = img.crop((0, crop_top, width, crop_bottom))
    
    # 2. Resize to optimal width for mobile devices (800px is perfect for sharp high-density screens)
    target_width = 800
    aspect_ratio = cropped_img.height / cropped_img.width
    target_height = int(target_width * aspect_ratio)
    
    resized_img = cropped_img.resize((target_width, target_height), Image.Resampling.LANCZOS)
    print(f"Resized to: {resized_img.size}")
    
    # 3. Compress and save to WebP
    resized_img.save(output_path, "WEBP", quality=82)
    
    webp_size_bytes = os.path.getsize(output_path)
    compression_ratio = (1 - (webp_size_bytes / original_size_bytes)) * 100
    
    print(f"Saved optimized banner: {output_path}")
    print(f"New size: {resized_img.size} ({webp_size_bytes / 1024:.1f} KB)")
    print(f"Size reduction: {compression_ratio:.1f}%")
    
    # Clean up the large PNG file
    try:
        os.remove(input_path)
        print("Original heavy PNG file removed to keep the build light!")
    except Exception as e:
        print(f"Could not remove original file: {e}")

if __name__ == "__main__":
    optimize_banner()
