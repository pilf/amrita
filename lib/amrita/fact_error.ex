defmodule Amrita.FactError do
  defexception expected: nil,
               actual: nil,
               predicate: "",
               negation: false,
               prelude: "Expected",
               custom_message: nil

  def message do
    "fact failed"
  end

  def message(%{ custom_message: msg }) when not is_nil(msg) do
    msg
  end

  def message(exception) do
    "#{exception.prelude}:\n" <>
      "     #{Amrita.FactError.actual_result(exception)} |> #{Amrita.FactError.full_checker(exception)}"
  end

  def full_checker(exception) do
    Amrita.Checkers.to_s exception.predicate, exception.expected
  end

  def actual_result(exception) do
    if is_bitstring(exception.actual) do
      exception.actual
    else
     inspect exception.actual
    end
  end

end
