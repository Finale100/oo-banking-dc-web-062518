require 'bank_account.rb'
require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount, :execute_transaction

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    @execute_transaction ||= begin
      if sender.balance >= self.amount
         sender.balance -= self.amount
         receiver.balance += self.amount
         @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end
  def reverse_transfer
    if @execute_transaction == "complete"
      sender.balance += self.amount
      receiver.balance -= self.amount
      @status = "reversed"
    end
  end
end
