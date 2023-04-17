# credo:disable-for-this-file
defmodule ExAliyunOts.TableStoreSearch.SortMode do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :SORT_MODE_MIN
      def default() do
        :SORT_MODE_MIN
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:SORT_MODE_MIN) do
          0
        end

        def encode("SORT_MODE_MIN") do
          0
        end
      ),
      (
        def encode(:SORT_MODE_MAX) do
          1
        end

        def encode("SORT_MODE_MAX") do
          1
        end
      ),
      (
        def encode(:SORT_MODE_AVG) do
          2
        end

        def encode("SORT_MODE_AVG") do
          2
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(0) do
        :SORT_MODE_MIN
      end,
      def decode(1) do
        :SORT_MODE_MAX
      end,
      def decode(2) do
        :SORT_MODE_AVG
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{0, :SORT_MODE_MIN}, {1, :SORT_MODE_MAX}, {2, :SORT_MODE_AVG}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:SORT_MODE_MIN) do
          true
        end,
        def has_constant?(:SORT_MODE_MAX) do
          true
        end,
        def has_constant?(:SORT_MODE_AVG) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
