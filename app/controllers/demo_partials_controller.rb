class DemoPartialsController < ApplicationController
  def new
    @zone = t("demo_partials_controller.new")
    @date = Time.zone.today
  end

  def edit
    @zone = t("demo_partials_controller.edit")
    @date = Time.zone.today - 4
  end
end
