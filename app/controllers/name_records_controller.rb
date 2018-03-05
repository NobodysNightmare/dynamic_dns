# frozen_string_literal: true

class NameRecordsController < ApplicationController
  def index
    @name_records = NameRecord.all
  end

  def new
    @name_record = NameRecord.new
    render :edit
  end

  def edit
    @name_record = NameRecord.find(params[:id])
  end

  def create
    plain_secret = SecureRandom.hex(24)
    secret = BCrypt::Password.create(plain_secret)
    name_record = NameRecord.create(name_record_params.merge(client_secret_hash: secret))
    if name_record.persisted?
      flash[:success] = I18n.t('flashs.created_name_record',
                               secret: plain_secret)
    else
      flash_errors(name_record.errors)
    end
    redirect_to action: :index
  end

  def update
    name_record = NameRecord.find(params[:id])
    if name_record.update(name_record_params)
      flash[:success] = I18n.t('flashs.updated_model',
                               model: NameRecord.model_name.human)
    else
      flash_errors(name_record.errors)
    end

    redirect_to action: :index
  end

  def destroy
    NameRecord.find(params[:id]).destroy
    flash[:success] = I18n.t('flashs.destroyed_model',
                             model: NameRecord.model_name.human)
    redirect_to action: :index
  end

  private

  def name_record_params
    params.require(:name_record).permit(:fqdn, :client_id, :ipv4, :ipv6)
  end
end
