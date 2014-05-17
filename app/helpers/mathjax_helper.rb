module MathjaxHelper
  def mathjax_script_tag *element_ids
    js_array = element_ids.empty? ? '[]' : "['#{element_ids.join("','")}']"
    result = content_tag :script, type: 'text/x-mathjax-config' do
      "MathJax.Hub.Config({elements: #{js_array},messageStyle: 'none',tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});".html_safe
    end
    result += javascript_include_tag '/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML'
    result
  end
end
