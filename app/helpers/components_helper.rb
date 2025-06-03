module ComponentsHelper
  def brandColors
    "bg-linear-to-r text-transparent bg-clip-text from-purplerain to-pinkrain"
  end

  def hoverBrandColors
    "cursor-pointer hover:bg-linear-to-r hover:text-transparent hover:bg-clip-text hover:from-purplerain hover:to-pinkrain"
  end

  def formBarColors
    "placeholder:text-gray-400 font-medium w-full
    bg-wysiwyg outline-1 outline-brandwhite border-none p-3
    focus:ring-brandwhite focus:ring-2
    hover:bg-linear-to-r hover:from-purplerain-hr hover:via-pinkrain-hr hover:to-bluerain-hr
    focus:bg-linear-to-r focus:from-purplerain-hr focus:via-pinkrain-hr focus:to-bluerain-hr"
  end

  def floatingLabelBig
    "absolute font-work-sans start-1 duration-300 transform left-[-1px] origin-[0] p-3 text-gray-400
     peer-placeholder-shown:scale-100 peer-placeholder-shown:-translate-y-1/2 peer-placeholder-shown:top-1/2
     peer-focus:bg-white peer-focus:text-brandblack peer-focus:top-2 peer-focus:scale-30 peer-focus:-translate-y-10
     not-peer-placeholder-shown:bg-white not-peer-placeholder-shown:text-brandblack not-peer-placeholder-shown:top-2
     not-peer-placeholder-shown:scale-30 not-peer-placeholder-shown:-translate-y-10"
  end

  def floatingLabelSmall
    "#{floatingLabelBig} text-sm peer-focus:scale-65 not-peer-placeholder-shown:scale-65"
  end
end
