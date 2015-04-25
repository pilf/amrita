Code.require_file "../../test_helper.exs", __ENV__.file

defmodule Integration.CheckerFacts do
  alias Amrita.Message, as: Message
  use Amrita.Sweet
  import Support

   facts "about checkers with no expected argument" do
     defchecker thousand(actual) do
       actual |> equals 1000
     end

     fact "supports ! and positive form" do
       1000 |> thousand()
       1001 |> ! thousand()

       fail do
         1001 |> thousand()
         1000 |> ! thousand()
       end
     end
   end

  facts "about checkers with an expected argument" do
    defchecker valid(actual, expected) do
      actual |> equals expected
    end

    fact "supports ! and postive form" do
      100 |> valid 100
      100 |> ! valid 101

     fail do
       100 |> valid 101
       100 |> ! valid 100
     end
    end
  end

  facts "readable failure messages", m do
    defchecker a_thousand(actual) do
      rem(actual, 1000) |> equals 0
    end

    fact "about 1000s" do
      1000 |> a_thousand()   # true
      1200 |> ! a_thousand() # true
    end

    defchecker always_fails(a) do
      raise Amrita.FactError, custom_message: "Don't feel bad, this always happens"
      false
    end

    defchecker always_succeeds(_a) do
      true
    end

    fact "doesn't include incomprehensible function message"
    fact "should be able to return tuple with error message" do
      true |> always_fails()
    end
  end

  # facts "about checkers with many expected arguments" do
  #   defchecker sumed_up(actual, expected, x, y, z) do
  #     actual |> equals expected + x + y + z
  #   end
  #
  #   fact "supports ! and postive form" do
  #     Integration.CheckerFacts.sumed_up(190, 100, 20, 30, 40)
  #
  #     fail do
  #       100 |> sumed_up 100, 20, 30, 40
  #     end
  #   end
  # end

end
