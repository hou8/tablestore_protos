# credo:disable-for-this-file
defmodule ExAliyunOts.TableStoreSearch.SyncPhase do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :FULL
      def default() do
        :FULL
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:FULL) do
          1
        end

        def encode("FULL") do
          1
        end
      ),
      (
        def encode(:INCR) do
          2
        end

        def encode("INCR") do
          2
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(1) do
        :FULL
      end,
      def decode(2) do
        :INCR
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{1, :FULL}, {2, :INCR}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:FULL) do
          true
        end,
        def has_constant?(:INCR) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
