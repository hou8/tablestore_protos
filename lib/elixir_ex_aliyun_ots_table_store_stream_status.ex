# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.StreamStatus do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :STREAM_ENABLING
      def default() do
        :STREAM_ENABLING
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:STREAM_ENABLING) do
          1
        end

        def encode("STREAM_ENABLING") do
          1
        end
      ),
      (
        def encode(:STREAM_ACTIVE) do
          2
        end

        def encode("STREAM_ACTIVE") do
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
        :STREAM_ENABLING
      end,
      def decode(2) do
        :STREAM_ACTIVE
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{1, :STREAM_ENABLING}, {2, :STREAM_ACTIVE}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:STREAM_ENABLING) do
          true
        end,
        def has_constant?(:STREAM_ACTIVE) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
