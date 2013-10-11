class CatRental < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date

  validates_presence_of :cat_id, :start_date, :end_date
  validate :start_date_is_before_end_date

  belongs_to :cat, :dependent => :destroy

  def approve!
    return unless self.status == "PENDING"
    if self.overlapping_requests.length == 0
      self.status = "APPROVED"
      self.save
    else
      errors[:status] << "Conflicting request"
      deny!
    end
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  private

    def start_date_is_before_end_date
      if start_date > end_date
        error[:start_date] << "Start date cannot be before end date!"
      end
    end

    def overlapping_requests
      date_range = (start_date..end_date)
      conflicting_rentals = CatRental.find_by_sql([<<-SQL, date_range, date_range, cat_id])
        SELECT *
        FROM cat_rentals
        WHERE (start_date IN (?)
          OR end_date IN (?))
          AND status = "APPROVED"
          AND cat_id = ?
      SQL
    end
end