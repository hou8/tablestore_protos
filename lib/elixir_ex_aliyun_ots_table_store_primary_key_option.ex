# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.PrimaryKeyOption do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :AUTO_INCREMENT
      def default() do
        :AUTO_INCREMENT
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:AUTO_INCREMENT) do
          1
        end

        def encode("AUTO_INCREMENT") do
          1
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(1) do
        :AUTO_INCREMENT
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{1, :AUTO_INCREMENT}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:AUTO_INCREMENT) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
