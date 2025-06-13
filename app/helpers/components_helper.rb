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
     peer-focus:bg-white peer-focus:text-brandblack peer-focus:top-2 peer-focus:scale-30 peer-focus:-translate-y-10.5
     not-peer-placeholder-shown:bg-white not-peer-placeholder-shown:text-brandblack not-peer-placeholder-shown:top-2
     not-peer-placeholder-shown:scale-30 not-peer-placeholder-shown:-translate-y-10.5"
  end

  def floatingLabelSmall
    "#{floatingLabelBig} text-sm peer-focus:scale-65 not-peer-placeholder-shown:scale-65"
  end

  def rsvpLabelForm
    "aspect-square cursor-pointer relative mx-1 min-w-33 md:min-w-25 lg:w-34 xl:w-38 w-full h-auto bg-purple-50 rounded-full flex flex-col justify-center items-center
    peer-checked:shadow-[0_0px_12px_5px_rgba(255,255,255,0.75)_inset] peer-checked:ring-4 peer-checked:ring-bluerain-hr
    peer-checked:bg-radial-[at_65%_20%] peer-checked:from-brandwhite peer-checked:to-greenrain peer-checked:to-80% transition delay-25 duration-250
    p-2 bg-linear-to-r from-purplerain-hr to-pinkrain-hr hover:brightness-95"
  end
end
