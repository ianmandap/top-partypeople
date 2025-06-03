module ComponentsHelper
  def brandColors
    "bg-linear-to-r text-transparent bg-clip-text from-purplerain to-pinkrain"
  end

  def hoverBrandColors
    "cursor-pointer hover:bg-linear-to-r hover:text-transparent hover:bg-clip-text hover:from-purplerain hover:to-pinkrain"
  end

  def formBarColors
    "placeholder:text-gray-400 font-medium
    bg-wysiwyg border-2 border-wysiwyg p-3
    hover:bg-linear-to-r hover:from-purplerain-hr hover:via-pinkrain-hr hover:to-bluerain-hr
    focus:bg-linear-to-r focus:from-purplerain-hr focus:via-pinkrain-hr focus:to-bluerain-hr"
  end
end
