class Api::V1::GraphitiController < ApplicationController
  skip_before_action :authenticate_user!

  include Graphiti::Rails::Responders
end
