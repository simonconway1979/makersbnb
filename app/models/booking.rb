require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource

  property :id, Serial
  property :status, String, default: "pending"

  belongs_to :user
  belongs_to :listing


end
