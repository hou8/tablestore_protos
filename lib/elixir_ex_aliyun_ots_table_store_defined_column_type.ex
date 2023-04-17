# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.DefinedColumnType do
  @moduledoc false
  (
    defstruct []

    (
      @spec default() :: :DCT_INTEGER
      def default() do
        :DCT_INTEGER
      end
    )

    @spec encode(atom() | String.t()) :: integer() | atom()
    [
      (
        def encode(:DCT_INTEGER) do
          1
        end

        def encode("DCT_INTEGER") do
          1
        end
      ),
      (
        def encode(:DCT_DOUBLE) do
          2
        end

        def encode("DCT_DOUBLE") do
          2
        end
      ),
      (
        def encode(:DCT_BOOLEAN) do
          3
        end

        def encode("DCT_BOOLEAN") do
          3
        end
      ),
      (
        def encode(:DCT_STRING) do
          4
        end

        def encode("DCT_STRING") do
          4
        end
      ),
      (
        def encode(:DCT_BLOB) do
          7
        end

        def encode("DCT_BLOB") do
          7
        end
      )
    ]

    def encode(x) do
      x
    end

    @spec decode(integer()) :: atom() | integer()
    [
      def decode(1) do
        :DCT_INTEGER
      end,
      def decode(2) do
        :DCT_DOUBLE
      end,
      def decode(3) do
        :DCT_BOOLEAN
      end,
      def decode(4) do
        :DCT_STRING
      end,
      def decode(7) do
        :DCT_BLOB
      end
    ]

    def decode(x) do
      x
    end

    @spec constants() :: [{integer(), atom()}]
    def constants() do
      [{1, :DCT_INTEGER}, {2, :DCT_DOUBLE}, {3, :DCT_BOOLEAN}, {4, :DCT_STRING}, {7, :DCT_BLOB}]
    end

    @spec has_constant?(any()) :: boolean()
    (
      [
        def has_constant?(:DCT_INTEGER) do
          true
        end,
        def has_constant?(:DCT_DOUBLE) do
          true
        end,
        def has_constant?(:DCT_BOOLEAN) do
          true
        end,
        def has_constant?(:DCT_STRING) do
          true
        end,
        def has_constant?(:DCT_BLOB) do
          true
        end
      ]

      def has_constant?(_) do
        false
      end
    )
  )
end
