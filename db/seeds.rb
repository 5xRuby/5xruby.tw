%w[faqs speakers].each do |name|
  ary = YAML.load(File.read(Rails.root.join('db', "#{name}.yml")))
  name.classify.constantize.create(ary)
end