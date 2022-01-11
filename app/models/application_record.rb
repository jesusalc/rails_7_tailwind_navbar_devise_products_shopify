# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def to_hash
    vars = {}
    instance_variables.each { |v| vars[v.to_s.delete('@')] = instance_variable_get(v) }
    vars = vars.reject { |v| v =~ /((changed_)?attributes)|(errors)/ }
    attributes.merge(vars)
  end
end
