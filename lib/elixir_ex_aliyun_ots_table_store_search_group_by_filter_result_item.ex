# credo:disable-for-this-file
defmodule ExAliyunOts.TableStoreSearch.GroupByFilterResultItem do
  @moduledoc false
  defstruct row_count: nil, sub_aggs_result: nil, sub_group_bys_result: nil

  (
    (
      @spec encode(struct) :: {:ok, iodata} | {:error, any}
      def encode(msg) do
        try do
          {:ok, encode!(msg)}
        rescue
          e in [Protox.EncodingError, Protox.RequiredFieldsError] -> {:error, e}
        end
      end

      @spec encode!(struct) :: iodata | no_return
      def encode!(msg) do
        []
        |> encode_row_count(msg)
        |> encode_sub_aggs_result(msg)
        |> encode_sub_group_bys_result(msg)
      end
    )

    []

    [
      defp encode_row_count(acc, msg) do
        try do
          case msg.row_count do
            nil -> acc
            _ -> [acc, "\b", Protox.Encode.encode_int64(msg.row_count)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:row_count, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_sub_aggs_result(acc, msg) do
        try do
          case msg.sub_aggs_result do
            nil -> acc
            _ -> [acc, "\x12", Protox.Encode.encode_message(msg.sub_aggs_result)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:sub_aggs_result, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_sub_group_bys_result(acc, msg) do
        try do
          case msg.sub_group_bys_result do
            nil -> acc
            _ -> [acc, "\x1A", Protox.Encode.encode_message(msg.sub_group_bys_result)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:sub_group_bys_result, "invalid field value"),
                    __STACKTRACE__
        end
      end
    ]

    []
  )

  (
    (
      @spec decode(binary) :: {:ok, struct} | {:error, any}
      def decode(bytes) do
        try do
          {:ok, decode!(bytes)}
        rescue
          e in [Protox.DecodingError, Protox.IllegalTagError, Protox.RequiredFieldsError] ->
            {:error, e}
        end
      end

      (
        @spec decode!(binary) :: struct | no_return
        def decode!(bytes) do
          parse_key_value(bytes, struct(ExAliyunOts.TableStoreSearch.GroupByFilterResultItem))
        end
      )
    )

    (
      @spec parse_key_value(binary, struct) :: struct
      defp parse_key_value(<<>>, msg) do
        msg
      end

      defp parse_key_value(bytes, msg) do
        {field, rest} =
          case Protox.Decode.parse_key(bytes) do
            {0, _, _} ->
              raise %Protox.IllegalTagError{}

            {1, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int64(bytes)
              {[row_count: value], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 sub_aggs_result:
                   Protox.MergeMessage.merge(
                     msg.sub_aggs_result,
                     ExAliyunOts.TableStoreSearch.AggregationsResult.decode!(delimited)
                   )
               ], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[
                 sub_group_bys_result:
                   Protox.MergeMessage.merge(
                     msg.sub_group_bys_result,
                     ExAliyunOts.TableStoreSearch.GroupBysResult.decode!(delimited)
                   )
               ], rest}

            {tag, wire_type, rest} ->
              {_, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)
              {[], rest}
          end

        msg_updated = struct(msg, field)
        parse_key_value(rest, msg_updated)
      end
    )

    []
  )

  (
    @spec json_decode(iodata(), keyword()) :: {:ok, struct()} | {:error, any()}
    def json_decode(input, opts \\ []) do
      try do
        {:ok, json_decode!(input, opts)}
      rescue
        e in Protox.JsonDecodingError -> {:error, e}
      end
    end

    @spec json_decode!(iodata(), keyword()) :: struct() | no_return()
    def json_decode!(input, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :decode)

      Protox.JsonDecode.decode!(
        input,
        ExAliyunOts.TableStoreSearch.GroupByFilterResultItem,
        &json_library_wrapper.decode!(json_library, &1)
      )
    end

    @spec json_encode(struct(), keyword()) :: {:ok, iodata()} | {:error, any()}
    def json_encode(msg, opts \\ []) do
      try do
        {:ok, json_encode!(msg, opts)}
      rescue
        e in Protox.JsonEncodingError -> {:error, e}
      end
    end

    @spec json_encode!(struct(), keyword()) :: iodata() | no_return()
    def json_encode!(msg, opts \\ []) do
      {json_library_wrapper, json_library} = Protox.JsonLibrary.get_library(opts, :encode)
      Protox.JsonEncode.encode!(msg, &json_library_wrapper.encode!(json_library, &1))
    end
  )

  (
    @deprecated "Use fields_defs()/0 instead"
    @spec defs() :: %{
            required(non_neg_integer) => {atom, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs() do
      %{
        1 => {:row_count, {:scalar, 0}, :int64},
        2 =>
          {:sub_aggs_result, {:scalar, nil},
           {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}},
        3 =>
          {:sub_group_bys_result, {:scalar, nil},
           {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        row_count: {1, {:scalar, 0}, :int64},
        sub_aggs_result:
          {2, {:scalar, nil}, {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}},
        sub_group_bys_result:
          {3, {:scalar, nil}, {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "rowCount",
          kind: {:scalar, 0},
          label: :optional,
          name: :row_count,
          tag: 1,
          type: :int64
        },
        %{
          __struct__: Protox.Field,
          json_name: "subAggsResult",
          kind: {:scalar, nil},
          label: :optional,
          name: :sub_aggs_result,
          tag: 2,
          type: {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}
        },
        %{
          __struct__: Protox.Field,
          json_name: "subGroupBysResult",
          kind: {:scalar, nil},
          label: :optional,
          name: :sub_group_bys_result,
          tag: 3,
          type: {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:row_count) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rowCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :row_count,
             tag: 1,
             type: :int64
           }}
        end

        def field_def("rowCount") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rowCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :row_count,
             tag: 1,
             type: :int64
           }}
        end

        def field_def("row_count") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "rowCount",
             kind: {:scalar, 0},
             label: :optional,
             name: :row_count,
             tag: 1,
             type: :int64
           }}
        end
      ),
      (
        def field_def(:sub_aggs_result) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subAggsResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_aggs_result,
             tag: 2,
             type: {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}
           }}
        end

        def field_def("subAggsResult") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subAggsResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_aggs_result,
             tag: 2,
             type: {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}
           }}
        end

        def field_def("sub_aggs_result") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subAggsResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_aggs_result,
             tag: 2,
             type: {:message, ExAliyunOts.TableStoreSearch.AggregationsResult}
           }}
        end
      ),
      (
        def field_def(:sub_group_bys_result) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subGroupBysResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_group_bys_result,
             tag: 3,
             type: {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}
           }}
        end

        def field_def("subGroupBysResult") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subGroupBysResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_group_bys_result,
             tag: 3,
             type: {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}
           }}
        end

        def field_def("sub_group_bys_result") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "subGroupBysResult",
             kind: {:scalar, nil},
             label: :optional,
             name: :sub_group_bys_result,
             tag: 3,
             type: {:message, ExAliyunOts.TableStoreSearch.GroupBysResult}
           }}
        end
      ),
      def field_def(_) do
        {:error, :no_such_field}
      end
    ]
  )

  []

  (
    @spec required_fields() :: []
    def required_fields() do
      []
    end
  )

  (
    @spec syntax() :: atom()
    def syntax() do
      :proto2
    end
  )

  [
    @spec(default(atom) :: {:ok, boolean | integer | String.t() | float} | {:error, atom}),
    def default(:row_count) do
      {:ok, 0}
    end,
    def default(:sub_aggs_result) do
      {:ok, nil}
    end,
    def default(:sub_group_bys_result) do
      {:ok, nil}
    end,
    def default(_) do
      {:error, :no_such_field}
    end
  ]

  (
    @spec file_options() :: nil
    def file_options() do
      nil
    end
  )
end
