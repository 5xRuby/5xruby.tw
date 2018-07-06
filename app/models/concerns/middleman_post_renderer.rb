module MiddlemanPostRenderer
  extend ActiveSupport::Concern

  Template = ERB.new <<-EOF
<%=mman_meta_data.to_yaml%>
---

<%=content%>
EOF

  def mman_meta_data
    {
      title: title,
      date: publish_at.utc.strftime("%Y-%m-%d %H:%M %Z"),
      slug: permalink,
      author: author.try(:name),
      tags: tag_list.join(', '),
      category: main_cat,
      image: {
        original: image.to_s.gsub("/uploads/", ''),
        preview: image.preview.to_s.gsub("/uploads/", ''),
        thumb: image.thumb.to_s.gsub("/uploads/", '')
      }
    }
  end

  def output_file_name
    mfn = [publish_at.utc.strftime('%Y-%m-%d'), permalink].join("-")
    if markup_type == "markdown"
      "#{mfn}.html.md"
    else
      "#{mfn}.html"
    end
  end

  def main_cat
    (Settings.posts_cate_tags & tag_list).first.to_s
  end

  def as_middleman_post
    Template.result binding
  end

end
