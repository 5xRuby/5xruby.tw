module MiddlemanPostRenderer
  extend ActiveSupport::Concern

  Template = ERB.new <<-EOF
  ---

  title: <%=title%>
  date: <%=publish_at.utc.strftime("%Y-%m-%d %h:%m %Z")%>
  slug: <%=permalink%>
  author: <%=author.try(:name)%>
  tags: <%=tag_list.join ", "%>
  category: <%=main_cat%>
  cover_image: <%=image.to_s.gsub("/uploads/","")%>
  markup_type: <%=markup_type%>

  ---

  <%=content%>

  EOF

  def output_file_name
    mfn = [publish_at.utc.strftime('%Y-%m-%d'), permalink].join("-")
    if markup_type == "markdown"
      "#{mfn}.html.md"
    else
      "#{mfn}.html"
    end
  end

  def main_cat
    Settings.posts_cate_tags & tag_list
  end

  def as_middleman_post
    Template.result binding
  end

end
