# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.UpdateTableRequest do
  @moduledoc false
  defstruct table_name: nil, reserved_throughput: nil, table_options: nil, stream_spec: nil

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
        |> encode_table_name(msg)
        |> encode_reserved_throughput(msg)
        |> encode_table_options(msg)
        |> encode_stream_spec(msg)
      end
    )

    []

    [
      defp encode_table_name(acc, msg) do
        try do
          case msg.table_name do
            nil -> raise Protox.RequiredFieldsError.new([:table_name])
            _ -> [acc, "\n", Protox.Encode.encode_string(msg.table_name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:table_name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_reserved_throughput(acc, msg) do
        try do
          case msg.reserved_throughput do
            nil -> acc
            _ -> [acc, "\x12", Protox.Encode.encode_message(msg.reserved_throughput)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:reserved_throughput, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_table_options(acc, msg) do
        try do
          case msg.table_options do
            nil -> acc
            _ -> [acc, "\x1A", Protox.Encode.encode_message(msg.table_options)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:table_options, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_stream_spec(acc, msg) do
        try do
          case msg.stream_spec do
            nil -> acc
            _ -> [acc, "\"", Protox.Encode.encode_message(msg.stream_spec)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:stream_spec, "invalid field value"), __STACKTRACE__
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
          {msg, set_fields} =
            parse_key_value([], bytes, struct(ExAliyunOts.TableStore.UpdateTableRequest))

          case [:table_name] -- set_fields do
            [] -> msg
            missing_fields -> raise Protox.RequiredFieldsError.new(missing_fields)
          end
        end
      )
    )

    (
      @spec parse_key_value([atom], binary, struct) :: {struct, [atom]}
      defp parse_key_value(set_fields, <<>>, msg) do
        {msg, set_fields}
      end

      defp parse_key_value(set_fields, bytes, msg) do
        {new_set_fields, field, rest} =
          case Protox.Decode.parse_key(bytes) do
            {0, _, _} ->
              raise %Protox.IllegalTagError{}

            {1, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[:table_name | set_fields], [table_name: delimited], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:reserved_throughput | set_fields],
               [
                 reserved_throughput:
                   Protox.MergeMessage.merge(
                     msg.reserved_throughput,
                     ExAliyunOts.TableStore.ReservedThroughput.decode!(delimited)
                   )
               ], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:table_options | set_fields],
               [
                 table_options:
                   Protox.MergeMessage.merge(
                     msg.table_options,
                     ExAliyunOts.TableStore.TableOptions.decode!(delimited)
                   )
               ], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:stream_spec | set_fields],
               [
                 stream_spec:
                   Protox.MergeMessage.merge(
                     msg.stream_spec,
                     ExAliyunOts.TableStore.StreamSpecification.decode!(delimited)
                   )
               ], rest}

            {tag, wire_type, rest} ->
              {_, rest} = Protox.Decode.parse_unknown(tag, wire_type, rest)
              {set_fields, [], rest}
          end

        msg_updated = struct(msg, field)
        parse_key_value(new_set_fields, rest, msg_updated)
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
        ExAliyunOts.TableStore.UpdateTableRequest,
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
        1 => {:table_name, {:scalar, ""}, :string},
        2 =>
          {:reserved_throughput, {:scalar, nil},
           {:message, ExAliyunOts.TableStore.ReservedThroughput}},
        3 => {:table_options, {:scalar, nil}, {:message, ExAliyunOts.TableStore.TableOptions}},
        4 =>
          {:stream_spec, {:scalar, nil}, {:message, ExAliyunOts.TableStore.StreamSpecification}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        reserved_throughput:
          {2, {:scalar, nil}, {:message, ExAliyunOts.TableStore.ReservedThroughput}},
        stream_spec: {4, {:scalar, nil}, {:message, ExAliyunOts.TableStore.StreamSpecification}},
        table_name: {1, {:scalar, ""}, :string},
        table_options: {3, {:scalar, nil}, {:message, ExAliyunOts.TableStore.TableOptions}}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "tableName",
          kind: {:scalar, ""},
          label: :required,
          name: :table_name,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "reservedThroughput",
          kind: {:scalar, nil},
          label: :optional,
          name: :reserved_throughput,
          tag: 2,
          type: {:message, ExAliyunOts.TableStore.ReservedThroughput}
        },
        %{
          __struct__: Protox.Field,
          json_name: "tableOptions",
          kind: {:scalar, nil},
          label: :optional,
          name: :table_options,
          tag: 3,
          type: {:message, ExAliyunOts.TableStore.TableOptions}
        },
        %{
          __struct__: Protox.Field,
          json_name: "streamSpec",
          kind: {:scalar, nil},
          label: :optional,
          name: :stream_spec,
          tag: 4,
          type: {:message, ExAliyunOts.TableStore.StreamSpecification}
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:table_name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableName",
             kind: {:scalar, ""},
             label: :required,
             name: :table_name,
             tag: 1,
             type: :string
           }}
        end

        def field_def("tableName") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableName",
             kind: {:scalar, ""},
             label: :required,
             name: :table_name,
             tag: 1,
             type: :string
           }}
        end

        def field_def("table_name") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableName",
             kind: {:scalar, ""},
             label: :required,
             name: :table_name,
             tag: 1,
             type: :string
           }}
        end
      ),
      (
        def field_def(:reserved_throughput) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "reservedThroughput",
             kind: {:scalar, nil},
             label: :optional,
             name: :reserved_throughput,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.ReservedThroughput}
           }}
        end

        def field_def("reservedThroughput") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "reservedThroughput",
             kind: {:scalar, nil},
             label: :optional,
             name: :reserved_throughput,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.ReservedThroughput}
           }}
        end

        def field_def("reserved_throughput") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "reservedThroughput",
             kind: {:scalar, nil},
             label: :optional,
             name: :reserved_throughput,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.ReservedThroughput}
           }}
        end
      ),
      (
        def field_def(:table_options) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableOptions",
             kind: {:scalar, nil},
             label: :optional,
             name: :table_options,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.TableOptions}
           }}
        end

        def field_def("tableOptions") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableOptions",
             kind: {:scalar, nil},
             label: :optional,
             name: :table_options,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.TableOptions}
           }}
        end

        def field_def("table_options") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableOptions",
             kind: {:scalar, nil},
             label: :optional,
             name: :table_options,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.TableOptions}
           }}
        end
      ),
      (
        def field_def(:stream_spec) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamSpec",
             kind: {:scalar, nil},
             label: :optional,
             name: :stream_spec,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.StreamSpecification}
           }}
        end

        def field_def("streamSpec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamSpec",
             kind: {:scalar, nil},
             label: :optional,
             name: :stream_spec,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.StreamSpecification}
           }}
        end

        def field_def("stream_spec") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamSpec",
             kind: {:scalar, nil},
             label: :optional,
             name: :stream_spec,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.StreamSpecification}
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
    @spec required_fields() :: [:table_name]
    def required_fields() do
      [:table_name]
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
    def default(:table_name) do
      {:ok, ""}
    end,
    def default(:reserved_throughput) do
      {:ok, nil}
    end,
    def default(:table_options) do
      {:ok, nil}
    end,
    def default(:stream_spec) do
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
