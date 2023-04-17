# credo:disable-for-this-file
defmodule ExAliyunOts.TableStoreSearch.CreateSearchIndexRequest do
  @moduledoc false
  defstruct table_name: nil,
            index_name: nil,
            schema: nil,
            source_index_name: nil,
            time_to_live: nil

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
        |> encode_index_name(msg)
        |> encode_schema(msg)
        |> encode_source_index_name(msg)
        |> encode_time_to_live(msg)
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
      defp encode_index_name(acc, msg) do
        try do
          case msg.index_name do
            nil -> raise Protox.RequiredFieldsError.new([:index_name])
            _ -> [acc, "\x12", Protox.Encode.encode_string(msg.index_name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:index_name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_schema(acc, msg) do
        try do
          case msg.schema do
            nil -> acc
            _ -> [acc, "\x1A", Protox.Encode.encode_message(msg.schema)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:schema, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_source_index_name(acc, msg) do
        try do
          case msg.source_index_name do
            nil -> acc
            _ -> [acc, "\"", Protox.Encode.encode_string(msg.source_index_name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:source_index_name, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_time_to_live(acc, msg) do
        try do
          case msg.time_to_live do
            nil -> acc
            _ -> [acc, "(", Protox.Encode.encode_int32(msg.time_to_live)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:time_to_live, "invalid field value"), __STACKTRACE__
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
            parse_key_value(
              [],
              bytes,
              struct(ExAliyunOts.TableStoreSearch.CreateSearchIndexRequest)
            )

          case [:table_name, :index_name] -- set_fields do
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
              {[:index_name | set_fields], [index_name: delimited], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:schema | set_fields],
               [
                 schema:
                   Protox.MergeMessage.merge(
                     msg.schema,
                     ExAliyunOts.TableStoreSearch.IndexSchema.decode!(delimited)
                   )
               ], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[:source_index_name | set_fields], [source_index_name: delimited], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[:time_to_live | set_fields], [time_to_live: value], rest}

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
        ExAliyunOts.TableStoreSearch.CreateSearchIndexRequest,
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
        2 => {:index_name, {:scalar, ""}, :string},
        3 => {:schema, {:scalar, nil}, {:message, ExAliyunOts.TableStoreSearch.IndexSchema}},
        4 => {:source_index_name, {:scalar, ""}, :string},
        5 => {:time_to_live, {:scalar, 0}, :int32}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        index_name: {2, {:scalar, ""}, :string},
        schema: {3, {:scalar, nil}, {:message, ExAliyunOts.TableStoreSearch.IndexSchema}},
        source_index_name: {4, {:scalar, ""}, :string},
        table_name: {1, {:scalar, ""}, :string},
        time_to_live: {5, {:scalar, 0}, :int32}
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
          json_name: "indexName",
          kind: {:scalar, ""},
          label: :required,
          name: :index_name,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "schema",
          kind: {:scalar, nil},
          label: :optional,
          name: :schema,
          tag: 3,
          type: {:message, ExAliyunOts.TableStoreSearch.IndexSchema}
        },
        %{
          __struct__: Protox.Field,
          json_name: "sourceIndexName",
          kind: {:scalar, ""},
          label: :optional,
          name: :source_index_name,
          tag: 4,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "timeToLive",
          kind: {:scalar, 0},
          label: :optional,
          name: :time_to_live,
          tag: 5,
          type: :int32
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
        def field_def(:index_name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexName",
             kind: {:scalar, ""},
             label: :required,
             name: :index_name,
             tag: 2,
             type: :string
           }}
        end

        def field_def("indexName") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexName",
             kind: {:scalar, ""},
             label: :required,
             name: :index_name,
             tag: 2,
             type: :string
           }}
        end

        def field_def("index_name") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexName",
             kind: {:scalar, ""},
             label: :required,
             name: :index_name,
             tag: 2,
             type: :string
           }}
        end
      ),
      (
        def field_def(:schema) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "schema",
             kind: {:scalar, nil},
             label: :optional,
             name: :schema,
             tag: 3,
             type: {:message, ExAliyunOts.TableStoreSearch.IndexSchema}
           }}
        end

        def field_def("schema") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "schema",
             kind: {:scalar, nil},
             label: :optional,
             name: :schema,
             tag: 3,
             type: {:message, ExAliyunOts.TableStoreSearch.IndexSchema}
           }}
        end

        []
      ),
      (
        def field_def(:source_index_name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sourceIndexName",
             kind: {:scalar, ""},
             label: :optional,
             name: :source_index_name,
             tag: 4,
             type: :string
           }}
        end

        def field_def("sourceIndexName") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sourceIndexName",
             kind: {:scalar, ""},
             label: :optional,
             name: :source_index_name,
             tag: 4,
             type: :string
           }}
        end

        def field_def("source_index_name") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sourceIndexName",
             kind: {:scalar, ""},
             label: :optional,
             name: :source_index_name,
             tag: 4,
             type: :string
           }}
        end
      ),
      (
        def field_def(:time_to_live) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeToLive",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_to_live,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("timeToLive") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeToLive",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_to_live,
             tag: 5,
             type: :int32
           }}
        end

        def field_def("time_to_live") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "timeToLive",
             kind: {:scalar, 0},
             label: :optional,
             name: :time_to_live,
             tag: 5,
             type: :int32
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
    @spec required_fields() :: [:table_name | :index_name]
    def required_fields() do
      [:table_name, :index_name]
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
    def default(:index_name) do
      {:ok, ""}
    end,
    def default(:schema) do
      {:ok, nil}
    end,
    def default(:source_index_name) do
      {:ok, ""}
    end,
    def default(:time_to_live) do
      {:ok, 0}
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
