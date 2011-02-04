# -*- coding: utf-8 -*-
class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  belongs_to :questions_party
  belongs_to :indicator

  named_scope :by_indicator, proc { |indicator| {:conditions => ["indicator_id = ?", indicator.id]}}
  named_scope :by_segment, proc { |segment| {:conditions => ["surveys.segment_id = ?", segment.id], :include => :survey} }
  named_scope :by_service_level, proc { |service_level| {:conditions => ["surveys.service_level_id = ?", service_level.id], :include => :survey}}

  def self.by_dimension_and_service_level(dimension, service_level)
    indicators = dimension.indicators.all(:conditions => ["service_level_id = ?", service_level.id])
    questions = (indicators.collect { |i| i.questions }).flatten!
    @questions_grouped = []
    service_level.segments.each do |seg|
      selected_questions = questions.select { |q| q.survey.segment == seg }
      @questions_grouped <<  { seg.name => selected_questions }
    end
    @questions_grouped
  end

  def colleagues
    group = []
    questions_party.questions.each do |q|
      group << q unless q == self
    end
    group
  end

  def survey_info
    "#{ServiceLevel.find(survey.service_level_id).name} - #{Segment.find(survey.segment_id).name}"
  end


  def <=>(other)
    comp =  survey_id <=> other.survey_id
    if comp == 0
      number <=> other.number
    else
      comp
    end
  end
end

