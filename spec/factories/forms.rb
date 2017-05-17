FactoryGirl.define do
  factory :form do
    title Faker::Name.title
    fields do
      [
        {"as"=>"string", "name"=>"address", "label"=>"你家地址", "required"=>true},
        {"as"=>"text", "name"=>"intro", "label"=>"自我介紹", "required"=>true},
        {"as"=>"file", "name"=>"avatar", "label"=>"大頭貼", "required"=>false},
        {"as"=>"select",
          "name"=>"education",
          "label"=>"教育程度",
          "collection"=>["國小", "國中", "高中", "大學"],
          "required"=>false},
        {"as"=>"check_boxes",
          "name"=>"interests",
          "label"=>"興趣",
          "collection"=>["吃飯", "睡覺", "寫扣"],
          "required"=>false},
        {"as"=>"radio_buttons",
          "name"=>"radio_buttons_1",
          "required"=>false,
          "label"=>"單選核取方塊",
          "collection"=>["選項一", "選項二", "選項三"]},
        {"as"=>"email_from_current_user",
          "name"=>"email_from_current_user_1",
          "required"=>true,
          "label"=>"Your Email"},
        {"as"=>"phone_from_current_user",
          "name"=>"phone_from_current_user_1",
          "required"=>true,
          "label"=>"Your Phone"},
        {"as"=>"username_from_current_user",
          "name"=>"username_from_current_user_1",
          "required"=>true,
          "label"=>"Your name"},
        {"as"=>"email", "name"=>"email_2", "required"=>false, "label"=>"some Email"},
        {"as"=>"url", "name"=>"url_1", "required"=>false, "label"=>"some url"},
        {"as"=>"tel", "name"=>"tel_1", "required"=>false, "label"=>"some telephone"}
      ]
    end
  end
end
