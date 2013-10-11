class CatRental < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date

  validates_presence_of :cat_id, :start_date, :end_date
  validate :start_date_is_before_end_date, :non_overlapping_request

  belongs_to :cat, :dependent => :destroy

  def approve!
    raise "request not pending" unless self.status == "PENDING"

    transaction do
      self.status = "APPROVED"
      self.save!
    
      overlapping_pending_requests.each do |request|
        request.status = "DENIED"
        request.save
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  private

    def start_date_is_before_end_date
      if start_date > end_date
        error[:start_date] << "Start date cannot be before end date!"
      end
    end

    def overlapping_requests
      date_range = (start_date..end_date)
      CatRental.find_by_sql(
        [<<-SQL, date_range, date_range, cat_id, id])
        SELECT *
        FROM cat_rentals
        WHERE (start_date IN (?)
          OR end_date IN (?))
          AND cat_id = ?
          AND id != ?
          AND status != "DENIED"
      SQL
    end

    def overlapping_approved_requests
      overlapping_requests.select do |rental|
        rental.status == 'APPROVED'
      end
    end

    def overlapping_pending_requests
      overlapping_requests.select do |rental|
        rental.status == 'PENDING'
      end
    end

    def non_overlapping_request
      unless overlapping_approved_requests.empty? ||
            status == "DENIED"
        errors[:start_date] << "You can't make a request that conflicts with an already confirmed request."
      end
    end
end