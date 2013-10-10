class AtLeastOneOfValidator < ActiveModel::Validator
  def validate(record)
    if record.name.blank? && record.email.blank?
      record.errors[:name] << "Must have either name or email. Both cannot be blank."
    end
  end
end