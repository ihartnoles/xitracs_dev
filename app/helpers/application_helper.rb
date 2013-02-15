module ApplicationHelper
  
  def full_title(page_title)
    base_title = "FAU"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def logo
    image_tag("fau.png", alt: "FAU", class: "round")
  end
  
  def ncurses_bold
    return "\e[1m"
  end

  def ncurses_smso 
    return "\e[7m"
  end
  
  def ncurses_rmso
    return "\e[27m"
  end
  
  def ncurses_sgr0
    return "\e(B\e[m"
  end
  
  
end
