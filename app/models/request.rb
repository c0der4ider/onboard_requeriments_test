class Request < ApplicationRecord
  has_many :votes
  belongs_to :user

  scope :order_by_alphabetic, -> { order("lower(title) ASC") }

  class << self
    # Get request by filtering system, using params to get the option,
    # that could be by ordering by numbers of votes or by alphabetic from
    # the request's title.
    #
    # * *Returns (output)* :
    # - requests filtered by params ordering.
    #
    def filter(params)
      requests = self.all
      if params[:order] == 'votes'
        # With comparable operator in the sorting method, between values order in reverse expression
        # to get ordered by descendant.
        requests = requests.sort { |x, y| y.get_points <=> x.get_points }
      elsif params[:order] == 'alphabetic'
        # Using scope, order request's title by alphabetic, but using lower function from PostgreSQL
        # (Without lower function, the requests ordering will have first Uppercase letters order, then downcase).
        requests = requests.order_by_alphabetic
      end
      requests
    end
  end

  # Get total point of votes for request by processing positive and negative.
  # In the votes table exists two kind of point using boolean, associated to
  # an user and request. By caculating total positives and negatives votes,
  # returning final point.
  #
  # * *Returns (output)* :
  # - Total points of votes for request.
  #
  def get_points
    number = 0
    votes.each do |vote|
      if vote.point == true
        number += 1
      else
        number -= 1
      end
    end
    number
  end

end
