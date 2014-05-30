module SocialHelperHelper
  # <div class="fb-share-button" data-href="" data-type="button_count"></div>
  def fb_share_btn href: request.url, type: :button_count, width: nil
    unless @fb_sdk # prevent duplicated sdk rendering
      content_for(:append_body, render('layouts/fb_sdk'))
      @fb_sdk = true
    end
    content_tag :div, nil, class: :'fb-share-button', data: {href: href, type: type, width: width}
  end
end
