ActiveAdmin.register Page do
  form do |f|

    f.inputs do
      f.input :content, :input_html => {:class => "ckeditor"}
    end
    f.buttons
  end

end
