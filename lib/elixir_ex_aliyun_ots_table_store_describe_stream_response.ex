# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.DescribeStreamResponse do
  @moduledoc false
  defstruct stream_id: nil,
            expiration_time: nil,
            table_name: nil,
            creation_time: nil,
            stream_status: nil,
            shards: [],
            next_shard_id: nil

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
        |> encode_stream_id(msg)
        |> encode_expiration_time(msg)
        |> encode_table_name(msg)
        |> encode_creation_time(msg)
        |> encode_stream_status(msg)
        |> encode_shards(msg)
        |> encode_next_shard_id(msg)
      end
    )

    []

    [
      defp encode_stream_id(acc, msg) do
        try do
          case msg.stream_id do
            nil -> raise Protox.RequiredFieldsError.new([:stream_id])
            _ -> [acc, "\n", Protox.Encode.encode_string(msg.stream_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:stream_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_expiration_time(acc, msg) do
        try do
          case msg.expiration_time do
            nil -> raise Protox.RequiredFieldsError.new([:expiration_time])
            _ -> [acc, "\x10", Protox.Encode.encode_int32(msg.expiration_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:expiration_time, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_table_name(acc, msg) do
        try do
          case msg.table_name do
            nil -> raise Protox.RequiredFieldsError.new([:table_name])
            _ -> [acc, "\x1A", Protox.Encode.encode_string(msg.table_name)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:table_name, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_creation_time(acc, msg) do
        try do
          case msg.creation_time do
            nil -> raise Protox.RequiredFieldsError.new([:creation_time])
            _ -> [acc, " ", Protox.Encode.encode_int64(msg.creation_time)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:creation_time, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_stream_status(acc, msg) do
        try do
          case msg.stream_status do
            nil ->
              raise Protox.RequiredFieldsError.new([:stream_status])

            _ ->
              [
                acc,
                "(",
                msg.stream_status
                |> ExAliyunOts.TableStore.StreamStatus.encode()
                |> Protox.Encode.encode_enum()
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:stream_status, "invalid field value"),
                    __STACKTRACE__
        end
      end,
      defp encode_shards(acc, msg) do
        try do
          case msg.shards do
            [] ->
              acc

            values ->
              [
                acc,
                Enum.reduce(values, [], fn value, acc ->
                  [acc, "2", Protox.Encode.encode_message(value)]
                end)
              ]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:shards, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_next_shard_id(acc, msg) do
        try do
          case msg.next_shard_id do
            nil -> acc
            _ -> [acc, ":", Protox.Encode.encode_string(msg.next_shard_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:next_shard_id, "invalid field value"),
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
            parse_key_value([], bytes, struct(ExAliyunOts.TableStore.DescribeStreamResponse))

          case [:stream_id, :expiration_time, :table_name, :creation_time, :stream_status] --
                 set_fields do
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
              {[:stream_id | set_fields], [stream_id: delimited], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[:expiration_time | set_fields], [expiration_time: value], rest}

            {3, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[:table_name | set_fields], [table_name: delimited], rest}

            {4, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int64(bytes)
              {[:creation_time | set_fields], [creation_time: value], rest}

            {5, _, bytes} ->
              {value, rest} = Protox.Decode.parse_enum(bytes, ExAliyunOts.TableStore.StreamStatus)
              {[:stream_status | set_fields], [stream_status: value], rest}

            {6, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)

              {[:shards | set_fields],
               [shards: msg.shards ++ [ExAliyunOts.TableStore.StreamShard.decode!(delimited)]],
               rest}

            {7, _, bytes} ->
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[:next_shard_id | set_fields], [next_shard_id: delimited], rest}

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
        ExAliyunOts.TableStore.DescribeStreamResponse,
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
        1 => {:stream_id, {:scalar, ""}, :string},
        2 => {:expiration_time, {:scalar, 0}, :int32},
        3 => {:table_name, {:scalar, ""}, :string},
        4 => {:creation_time, {:scalar, 0}, :int64},
        5 =>
          {:stream_status, {:scalar, :STREAM_ENABLING},
           {:enum, ExAliyunOts.TableStore.StreamStatus}},
        6 => {:shards, :unpacked, {:message, ExAliyunOts.TableStore.StreamShard}},
        7 => {:next_shard_id, {:scalar, ""}, :string}
      }
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{
        creation_time: {4, {:scalar, 0}, :int64},
        expiration_time: {2, {:scalar, 0}, :int32},
        next_shard_id: {7, {:scalar, ""}, :string},
        shards: {6, :unpacked, {:message, ExAliyunOts.TableStore.StreamShard}},
        stream_id: {1, {:scalar, ""}, :string},
        stream_status:
          {5, {:scalar, :STREAM_ENABLING}, {:enum, ExAliyunOts.TableStore.StreamStatus}},
        table_name: {3, {:scalar, ""}, :string}
      }
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "streamId",
          kind: {:scalar, ""},
          label: :required,
          name: :stream_id,
          tag: 1,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "expirationTime",
          kind: {:scalar, 0},
          label: :required,
          name: :expiration_time,
          tag: 2,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "tableName",
          kind: {:scalar, ""},
          label: :required,
          name: :table_name,
          tag: 3,
          type: :string
        },
        %{
          __struct__: Protox.Field,
          json_name: "creationTime",
          kind: {:scalar, 0},
          label: :required,
          name: :creation_time,
          tag: 4,
          type: :int64
        },
        %{
          __struct__: Protox.Field,
          json_name: "streamStatus",
          kind: {:scalar, :STREAM_ENABLING},
          label: :required,
          name: :stream_status,
          tag: 5,
          type: {:enum, ExAliyunOts.TableStore.StreamStatus}
        },
        %{
          __struct__: Protox.Field,
          json_name: "shards",
          kind: :unpacked,
          label: :repeated,
          name: :shards,
          tag: 6,
          type: {:message, ExAliyunOts.TableStore.StreamShard}
        },
        %{
          __struct__: Protox.Field,
          json_name: "nextShardId",
          kind: {:scalar, ""},
          label: :optional,
          name: :next_shard_id,
          tag: 7,
          type: :string
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:stream_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :required,
             name: :stream_id,
             tag: 1,
             type: :string
           }}
        end

        def field_def("streamId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :required,
             name: :stream_id,
             tag: 1,
             type: :string
           }}
        end

        def field_def("stream_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamId",
             kind: {:scalar, ""},
             label: :required,
             name: :stream_id,
             tag: 1,
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
             label: :required,
             name: :expiration_time,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("expirationTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expirationTime",
             kind: {:scalar, 0},
             label: :required,
             name: :expiration_time,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("expiration_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "expirationTime",
             kind: {:scalar, 0},
             label: :required,
             name: :expiration_time,
             tag: 2,
             type: :int32
           }}
        end
      ),
      (
        def field_def(:table_name) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "tableName",
             kind: {:scalar, ""},
             label: :required,
             name: :table_name,
             tag: 3,
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
             tag: 3,
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
             tag: 3,
             type: :string
           }}
        end
      ),
      (
        def field_def(:creation_time) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "creationTime",
             kind: {:scalar, 0},
             label: :required,
             name: :creation_time,
             tag: 4,
             type: :int64
           }}
        end

        def field_def("creationTime") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "creationTime",
             kind: {:scalar, 0},
             label: :required,
             name: :creation_time,
             tag: 4,
             type: :int64
           }}
        end

        def field_def("creation_time") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "creationTime",
             kind: {:scalar, 0},
             label: :required,
             name: :creation_time,
             tag: 4,
             type: :int64
           }}
        end
      ),
      (
        def field_def(:stream_status) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamStatus",
             kind: {:scalar, :STREAM_ENABLING},
             label: :required,
             name: :stream_status,
             tag: 5,
             type: {:enum, ExAliyunOts.TableStore.StreamStatus}
           }}
        end

        def field_def("streamStatus") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamStatus",
             kind: {:scalar, :STREAM_ENABLING},
             label: :required,
             name: :stream_status,
             tag: 5,
             type: {:enum, ExAliyunOts.TableStore.StreamStatus}
           }}
        end

        def field_def("stream_status") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "streamStatus",
             kind: {:scalar, :STREAM_ENABLING},
             label: :required,
             name: :stream_status,
             tag: 5,
             type: {:enum, ExAliyunOts.TableStore.StreamStatus}
           }}
        end
      ),
      (
        def field_def(:shards) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "shards",
             kind: :unpacked,
             label: :repeated,
             name: :shards,
             tag: 6,
             type: {:message, ExAliyunOts.TableStore.StreamShard}
           }}
        end

        def field_def("shards") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "shards",
             kind: :unpacked,
             label: :repeated,
             name: :shards,
             tag: 6,
             type: {:message, ExAliyunOts.TableStore.StreamShard}
           }}
        end

        []
      ),
      (
        def field_def(:next_shard_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "nextShardId",
             kind: {:scalar, ""},
             label: :optional,
             name: :next_shard_id,
             tag: 7,
             type: :string
           }}
        end

        def field_def("nextShardId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "nextShardId",
             kind: {:scalar, ""},
             label: :optional,
             name: :next_shard_id,
             tag: 7,
             type: :string
           }}
        end

        def field_def("next_shard_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "nextShardId",
             kind: {:scalar, ""},
             label: :optional,
             name: :next_shard_id,
             tag: 7,
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
    @spec required_fields() :: [
            (((:stream_id | :expiration_time) | :table_name) | :creation_time) | :stream_status
          ]
    def required_fields() do
      [:stream_id, :expiration_time, :table_name, :creation_time, :stream_status]
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
    def default(:stream_id) do
      {:ok, ""}
    end,
    def default(:expiration_time) do
      {:ok, 0}
    end,
    def default(:table_name) do
      {:ok, ""}
    end,
    def default(:creation_time) do
      {:ok, 0}
    end,
    def default(:stream_status) do
      {:ok, :STREAM_ENABLING}
    end,
    def default(:shards) do
      {:error, :no_default_value}
    end,
    def default(:next_shard_id) do
      {:ok, ""}
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
