# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.TableMeta do
  @moduledoc false
  defstruct table_name: nil, primary_key: [], defined_column: [], index_meta: []

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
        |> encode_primary_key(msg)
        |> encode_defined_column(msg)
        |> encode_index_meta(msg)
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
      defp encode_primary_key(acc, msg) do
        try do
          case msg.primary_key do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\x12", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:primary_key, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_defined_column(acc, msg) do
        try do
          case msg.defined_column do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\x1A", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:defined_column, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_index_meta(acc, msg) do
        try do
          case msg.index_meta do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "\"", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:index_meta, "invalid field value"), __STACKTRACE__
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
          {msg, set_fields} = parse_key_value([], bytes, struct(ExAliyunOts.TableStore.TableMeta))

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

              {[:primary_key | set_fields],
               [
                 primary_key:
                   msg.primary_key ++ [ExAliyunOts.TableStore.PrimaryKeySchema.decode!(delimited)]
               ], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:defined_column | set_fields],
               [
                 defined_column:
                   msg.defined_column ++
                     [ExAliyunOts.TableStore.DefinedColumnSchema.decode!(delimited)]
               ], rest}

            {4, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:index_meta | set_fields],
               [
                 index_meta:
                   msg.index_meta ++ [ExAliyunOts.TableStore.IndexMeta.decode!(delimited)]
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
        ExAliyunOts.TableStore.TableMeta,
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
        2 => {:primary_key, :unpacked, {:message, ExAliyunOts.TableStore.PrimaryKeySchema}},
        3 => {:defined_column, :unpacked, {:message, ExAliyunOts.TableStore.DefinedColumnSchema}},
        4 => {:index_meta, :unpacked, {:message, ExAliyunOts.TableStore.IndexMeta}}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        defined_column: {3, :unpacked, {:message, ExAliyunOts.TableStore.DefinedColumnSchema}},
        index_meta: {4, :unpacked, {:message, ExAliyunOts.TableStore.IndexMeta}},
        primary_key: {2, :unpacked, {:message, ExAliyunOts.TableStore.PrimaryKeySchema}},
        table_name: {1, {:scalar, ""}, :string}
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
          json_name: "primaryKey",
          kind: :unpacked,
          label: :repeated,
          name: :primary_key,
          tag: 2,
          type: {:message, ExAliyunOts.TableStore.PrimaryKeySchema}
        },
        %{
          __struct__: Protox.Field,
          json_name: "definedColumn",
          kind: :unpacked,
          label: :repeated,
          name: :defined_column,
          tag: 3,
          type: {:message, ExAliyunOts.TableStore.DefinedColumnSchema}
        },
        %{
          __struct__: Protox.Field,
          json_name: "indexMeta",
          kind: :unpacked,
          label: :repeated,
          name: :index_meta,
          tag: 4,
          type: {:message, ExAliyunOts.TableStore.IndexMeta}
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
        def field_def(:primary_key) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "primaryKey",
             kind: :unpacked,
             label: :repeated,
             name: :primary_key,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.PrimaryKeySchema}
           }}
        end

        def field_def("primaryKey") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "primaryKey",
             kind: :unpacked,
             label: :repeated,
             name: :primary_key,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.PrimaryKeySchema}
           }}
        end

        def field_def("primary_key") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "primaryKey",
             kind: :unpacked,
             label: :repeated,
             name: :primary_key,
             tag: 2,
             type: {:message, ExAliyunOts.TableStore.PrimaryKeySchema}
           }}
        end
      ),
      (
        def field_def(:defined_column) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "definedColumn",
             kind: :unpacked,
             label: :repeated,
             name: :defined_column,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.DefinedColumnSchema}
           }}
        end

        def field_def("definedColumn") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "definedColumn",
             kind: :unpacked,
             label: :repeated,
             name: :defined_column,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.DefinedColumnSchema}
           }}
        end

        def field_def("defined_column") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "definedColumn",
             kind: :unpacked,
             label: :repeated,
             name: :defined_column,
             tag: 3,
             type: {:message, ExAliyunOts.TableStore.DefinedColumnSchema}
           }}
        end
      ),
      (
        def field_def(:index_meta) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexMeta",
             kind: :unpacked,
             label: :repeated,
             name: :index_meta,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.IndexMeta}
           }}
        end

        def field_def("indexMeta") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexMeta",
             kind: :unpacked,
             label: :repeated,
             name: :index_meta,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.IndexMeta}
           }}
        end

        def field_def("index_meta") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "indexMeta",
             kind: :unpacked,
             label: :repeated,
             name: :index_meta,
             tag: 4,
             type: {:message, ExAliyunOts.TableStore.IndexMeta}
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
    def default(:primary_key) do
      {:error, :no_default_value}
    end,
    def default(:defined_column) do
      {:error, :no_default_value}
    end,
    def default(:index_meta) do
      {:error, :no_default_value}
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
