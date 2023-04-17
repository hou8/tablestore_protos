# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.StreamDetails do
  @moduledoc false
  defstruct enable_stream: nil,
            stream_id: nil,
            expiration_time: nil,
            last_enable_time: nil,
            columns_to_get: []

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
        |> encode_enable_stream(msg)
        |> encode_stream_id(msg)
        |> encode_expiration_time(msg)
        |> encode_last_enable_time(msg)
        |> encode_columns_to_get(msg)
      end
    )

    []

    [
      defp encode_enable_stream(acc, msg) do
        try do
          case msg.enable_stream do
            nil -> raise Protox.RequiredFieldsError.new([:enable_stream])
            _ -> [acc, "\b", Protox.Encode.encode_bool(msg.enable_stream)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:enable_stream, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_stream_id(acc, msg) do
        try do
          case msg.stream_id do
            nil -> acc
            _ -> [acc, "\x12", Protox.Encode.encode_string(msg.stream_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:stream_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_expiration_time(acc, msg) do
        try do
          case msg.expiration_time do
            nil -> acc
            _ -> [acc, "\x18", Protox.Encode.encode_int32(msg.expiration_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:expiration_time, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_last_enable_time(acc, msg) do
        try do
          case msg.last_enable_time do
            nil -> acc
            _ -> [acc, " ", Protox.Encode.encode_int64(msg.last_enable_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:last_enable_time, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_columns_to_get(acc, msg) do
        try do
          case msg.columns_to_get do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "*", Protox.Encode.encode_string(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:columns_to_get, "invalid field value"),
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
          {msg, set_fields} =
            parse_key_value([], bytes, struct(ExAliyunOts.TableStore.StreamDetails))

          case [:enable_stream] -- set_fields do
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
              {value, rest} = Protox.Decode.parse_bool(bytes)
              {[:enable_stream | set_fields], [enable_stream: value], rest}

            {2, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[:stream_id | set_fields], [stream_id: delimited], rest}

            {3, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[:expiration_time | set_fields], [expiration_time: value], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int64(bytes)
              {[:last_enable_time | set_fields], [last_enable_time: value], rest}

            {5, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:columns_to_get | set_fields],
               [columns_to_get: msg.columns_to_get ++ [delimited]], rest}

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
        ExAliyunOts.TableStore.StreamDetails,
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
        1 => {:enable_stream, {:scalar, false}, :bool},
        2 => {:stream_id, {:scalar, ""}, :string},
        3 => {:expiration_time, {:scalar, 0}, :int32},
        4 => {:last_enable_time, {:scalar, 0}, :int64},
        5 => {:columns_to_get, :unpacked, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        columns_to_get: {5, :unpacked, :string},
        enable_stream: {1, {:scalar, false}, :bool},
        expiration_time: {3, {:scalar, 0}, :int32},
        last_enable_time: {4, {:scalar, 0}, :int64},
        stream_id: {2, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "enableStream",
          kind: {:scalar, false},
          label: :required,
          name: :enable_stream,
          tag: 1,
          type: :bool
        },
        %{
          __struct__: Protox.Field,
          json_name: "streamId",
          kind: {:scalar, ""},
          label: :optional,
          name: :stream_id,
          tag: 2,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "expirationTime",
          kind: {:scalar, 0},
          label: :optional,
          name: :expiration_time,
          tag: 3,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "lastEnableTime",
          kind: {:scalar, 0},
          label: :optional,
          name: :last_enable_time,
          tag: 4,
          type: :int64
        },
        %{
          __struct__: Protox.Field,
          json_name: "columnsToGet",
          kind: :unpacked,
          label: :repeated,
          name: :columns_to_get,
          tag: 5,
          type: :string
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:enable_stream) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "enableStream",
             kind: {:scalar, false},
             label: :required,
             name: :enable_stream,
             tag: 1,
             type: :bool
           }}
        end

        def field_def("enableStream") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "enableStream",
             kind: {:scalar, false},
             label: :required,
             name: :enable_stream,
             tag: 1,
             type: :bool
           }}
        end

        def field_def("enable_stream") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "enableStream",
             kind: {:scalar, false},
             label: :required,
             name: :enable_stream,
             tag: 1,
             type: :bool
           }}
        end
      ),
      (
        def field_def(:stream_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :optional,
             name: :stream_id,
             tag: 2,
             type: :string
           }}
        end

        def field_def("streamId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :optional,
             name: :stream_id,
             tag: 2,
             type: :string
           }}
        end

        def field_def("stream_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :optional,
             name: :stream_id,
             tag: 2,
             type: :string
           }}
        end
      ),
      (
        def field_def(:expiration_time) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expirationTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :expiration_time,
             tag: 3,
             type: :int32
           }}
        end

        def field_def("expirationTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expirationTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :expiration_time,
             tag: 3,
             type: :int32
           }}
        end

        def field_def("expiration_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expirationTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :expiration_time,
             tag: 3,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:last_enable_time) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "lastEnableTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :last_enable_time,
             tag: 4,
             type: :int64
           }}
        end

        def field_def("lastEnableTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "lastEnableTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :last_enable_time,
             tag: 4,
             type: :int64
           }}
        end

        def field_def("last_enable_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "lastEnableTime",
             kind: {:scalar, 0},
             label: :optional,
             name: :last_enable_time,
             tag: 4,
             type: :int64
           }}
        end
      ),
      (
        def field_def(:columns_to_get) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "columnsToGet",
             kind: :unpacked,
             label: :repeated,
             name: :columns_to_get,
             tag: 5,
             type: :string
           }}
        end

        def field_def("columnsToGet") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "columnsToGet",
             kind: :unpacked,
             label: :repeated,
             name: :columns_to_get,
             tag: 5,
             type: :string
           }}
        end

        def field_def("columns_to_get") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "columnsToGet",
             kind: :unpacked,
             label: :repeated,
             name: :columns_to_get,
             tag: 5,
             type: :string
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
    @spec required_fields() :: [:enable_stream]
    def required_fields() do
      [:enable_stream]
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
    def default(:enable_stream) do
      {:ok, false}
    end,
    def default(:stream_id) do
      {:ok, ""}
    end,
    def default(:expiration_time) do
      {:ok, 0}
    end,
    def default(:last_enable_time) do
      {:ok, 0}
    end,
    def default(:columns_to_get) do
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
