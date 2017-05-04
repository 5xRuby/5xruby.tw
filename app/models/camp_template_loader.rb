class CampTemplateLoader < Settingslogic
  source "#{Rails.root}/config/camp.yml"

  class << self
    def use_or_default(camp_setting)
      camp_setting.nil? ? new : use(camp_setting)
    end

    def use(camp_setting)
      new(camp_setting)
    end
  end

  def initialize(source = self.class.source, section = nil)
    case source
    when nil
      raise Errno::ENOENT, "No file specified as Settingslogic source"
    when Hash
      self.replace source
    when CampSetting
      self.replace source.payload || {}
      section = "CampSetting with id = #{source.id}"
      add_root_methods
    else
      file_contents = open(source).read
      hash = file_contents.empty? ? {} : YAML.load(ERB.new(file_contents).result).to_hash
      if self.class.namespace
        hash = hash[self.class.namespace] or return missing_key("Missing setting '#{self.class.namespace}' in #{source}")
      end
      self.replace hash
      add_root_methods
    end
    @section = section || self.class.source
    create_accessors!
  end

  private

  def add_root_methods
    extend RootMethods
  end

  module RootMethods
    def days_before_begining
      (begin_date_parsed - Date.today).to_i
    end

    def begun?
      @past ||= begin_date_parsed.past?
    end

    def begin_date_parsed
      @begin_date_parsed ||= Date.parse(begin_date)
    end

    def days_before_ending
      (end_date_parsed - Date.today).to_i
    end

    def ended?
      @ended ||= end_date_parsed.past?
    end

    def end_date_parsed
      @end_date_parsed ||= Date.parse(end_date)
    end

    def courses
      @courses ||= lessons.map do |lesson|
        raise "Course not found by permalink '#{lesson['course_permalink']}'" unless lesson['record'] = Course.find_by(permalink: lesson['course_permalink'])
        lesson
      end
    end
  end
end
