module Manageable
  module Models
    module ActsAsArticle
      extend ActiveSupport::Concern

      included do
        before_save :set_slug, :set_published

        validates :title, :presence => true, :uniqueness => {:scope => :category_id, :case_sensitive => false, :if => Proc.new { |article| article.respond_to?(:category_id) }}
        validates :locale, :presence => true

        scope :unpublished, where(:published_at => nil)
        scope :published,   lambda { where(arel_table[:published_at].not_eq(nil)) }
        scope :highlighted, lambda { where(:highlight => true) }
        scope :for_slug,    lambda { |param| where(:slug => param) }
        scope :for_locale,  lambda { |locale| where(:locale => locale) }
        scope :for_published_at, (lambda do |year, month = nil, day = nil|
          beginning_date, end_date = if month.nil? && day.nil?
            [Date.new(year).beginning_of_year, Date.new(year).end_of_year]
          elsif day.nil?
            [Date.new(year, month).beginning_of_month, Date.new(year, month).end_of_month]
          else
            [Date.new(year, month, day).beginning_of_day, Date.new(year, month, day).end_of_day]
          end

          where("published_at >= ? AND published_at <= ?", beginning_date, end_date)
        end)
        scope :sorted,      (lambda do |*args|
          sort = args.first
          order(sort ? sort : 'highlight DESC, published_at DESC')
        end)
      end

      def to_url_param
        self.slug
      end

      def publish_now=(value)
        @publish_now = (value && !(value === 'false'))
      end

      private

      def set_slug
        self.slug = "#{self.title.parameterize}" if self.title
      end

      def set_published
        self.published_at = DateTime.now if @publish_now
      end
    end
  end
end
