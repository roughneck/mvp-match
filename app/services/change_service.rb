class ChangeService
  attr_reader :deposit, :change_hash

  def initialize(deposit)
    @deposit = deposit
    @change_hash = { 5 => 0, 10 => 0, 20 => 0, 50 => 0, 100 => 0 }
  end

  def call
    give_change
  end

  def give_change(remaining_deposit = nil)
    remaining_deposit ||= deposit

    if remaining_deposit >= 100
      change_hash[100] += 1
      give_change(remaining_deposit - 100)
    elsif remaining_deposit >= 50
      change_hash[50] += 1
      give_change(remaining_deposit - 50)
    elsif remaining_deposit >= 20
      change_hash[20] += 1
      give_change(remaining_deposit - 20)
    elsif remaining_deposit >= 10
      change_hash[10] += 1
      give_change(remaining_deposit - 10)
    elsif remaining_deposit >= 5
      change_hash[5] += 1
      give_change(remaining_deposit - 5)
    end

    change_hash
  end
end
