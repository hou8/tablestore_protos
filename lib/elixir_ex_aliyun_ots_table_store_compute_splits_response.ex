# credo:disable-for-this-file
defmodule ExAliyunOts.TableStore.ComputeSplitsResponse do
  @moduledoc false
  defstruct session_id: nil, splits_size: nil

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
        [] |> encode_session_id(msg) |> encode_splits_size(msg)
      end
    )

    []

    [
      defp encode_session_id(acc, msg) do
        try do
          case msg.session_id do
            nil -> acc
            _ -> [acc, "\n", Protox.Encode.encode_bytes(msg.session_id)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:session_id, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_splits_size(acc, msg) do
        try do
          case msg.splits_size do
            nil -> acc
            _ -> [acc, "\x10", Protox.Encode.encode_int32(msg.splits_size)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:splits_size, "invalid field value"), __STACKTRACE__
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
          parse_key_value(bytes, struct(ExAliyunOts.TableStore.ComputeSplitsResponse))
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
              {len, bytes} = Protox.Varint.decode(bytes)
              {delimited, rest} = Protox.Decode.parse_delimited(bytes, len)
              {[session_id: delimited], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[splits_size: value], rest}

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
        ExAliyunOts.TableStore.ComputeSplitsResponse,
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
      %{1 => {:session_id, {:scalar, ""}, :bytes}, 2 => {:splits_size, {:scalar, 0}, :int32}}
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{session_id: {1, {:scalar, ""}, :bytes}, splits_size: {2, {:scalar, 0}, :int32}}
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "sessionId",
          kind: {:scalar, ""},
          label: :optional,
          name: :session_id,
          tag: 1,
          type: :bytes
        },
        %{
          __struct__: Protox.Field,
          json_name: "splitsSize",
          kind: {:scalar, 0},
          label: :optional,
          name: :splits_size,
          tag: 2,
          type: :int32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:session_id) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sessionId",
             kind: {:scalar, ""},
             label: :optional,
             name: :session_id,
             tag: 1,
             type: :bytes
           }}
        end

        def field_def("sessionId") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sessionId",
             kind: {:scalar, ""},
             label: :optional,
             name: :session_id,
             tag: 1,
             type: :bytes
           }}
        end

        def field_def("session_id") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "sessionId",
             kind: {:scalar, ""},
             label: :optional,
             name: :session_id,
             tag: 1,
             type: :bytes
           }}
        end
      ),
      (
        def field_def(:splits_size) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "splitsSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :splits_size,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("splitsSize") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "splitsSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :splits_size,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("splits_size") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "splitsSize",
             kind: {:scalar, 0},
             label: :optional,
             name: :splits_size,
             tag: 2,
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
    def default(:session_id) do
      {:ok, ""}
    end,
    def default(:splits_size) do
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
