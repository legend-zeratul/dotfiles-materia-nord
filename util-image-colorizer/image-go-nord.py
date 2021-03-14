from ImageGoNord import NordPaletteFile, GoNord
from PIL import ImageFilter

import argparse
from os import path
from subprocess import run

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('input', help='File to generate image from.')
  parser.add_argument(
      '-s', '--show', help='Show image using xdg-open when image is generated.', action='store_true')
  parser.add_argument(
      '-b', '--blur', help='Blur the image', action='store_true')
  parser.add_argument(
      '--no_quantize', help='Do not quantize the image before processing (may make the image look better)', action='store_true')
  args = parser.parse_args()

  sInputImage = args.input
  sOutputPath = './nordified/' + path.splitext(path.basename(sInputImage))[0] + '-nordified.jpg'

  print(f"Writing nordified version to {sOutputPath}..")

  go_nord = GoNord()

  image = go_nord.open_image(sInputImage)
  if args.blur:
    image = image.filter(ImageFilter.GaussianBlur(5))
  
  go_nord.set_default_nord_palette()
  #go_nord.disable_avg_algorithm()
  
  image = go_nord.quantize_image(image, save_path=sOutputPath)
  #go_nord.convert_image(image, save_path=sOutputPath)

  # To base64
  #go_nord.image_to_base64(image, 'jpeg')
  print("Done.")

  if args.show:
    run('xdg-open {}'.format(sOutputPath), shell=True)

if __name__ == '__main__':
  main()


## Original GoNord source..
#image = go_nord.open_image(sInputImage)
#go_nord.convert_image(image, save_path=sOutputPath+'-1.jpg')

# E.g. Avg algorithm and less colors
#go_nord.enable_avg_algorithm()
#go_nord.reset_palette()
#go_nord.add_file_to_palette(NordPaletteFile.POLAR_NIGHT)
#go_nord.add_file_to_palette(NordPaletteFile.SNOW_STORM)

# You can add color also by their hex code
#go_nord.add_color_to_palette('#FF0000')

#image = go_nord.open_image(sInputImage)
#go_nord.convert_image(image, save_path=sOutputPath+'-2.jpg')

# E.g. Resized img no Avg algorithm and less colors
#go_nord.disable_avg_algorithm()
#go_nord.reset_palette()
#go_nord.add_file_to_palette(NordPaletteFile.POLAR_NIGHT)
#go_nord.add_file_to_palette(NordPaletteFile.SNOW_STORM)

#image = go_nord.open_image(sInputImage)
#resized_img = go_nord.resize_image(image)
#go_nord.convert_image(resized_img, save_path=sOutputPath+'-3.jpg')

# E.g. Quantize
