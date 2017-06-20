module SocialHelperHelper
  # <div class="fb-like" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button_count" data-action="like" data-size="large" data-share="true"></div>
  def fb_share_btn href: request.url, layout: :button_count, size: :large, action: :like, share: true
    unless @fb_sdk # prevent duplicated sdk rendering
      content_for(:append_body, render('layouts/fb_sdk'))
      @fb_sdk = true
    end
    content_tag :div, nil, class: :'fb-like', data: {href: href, layout: layout, size: size, action: action, share: share}
  end
end
