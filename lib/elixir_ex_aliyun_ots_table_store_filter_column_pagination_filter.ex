# credo:disable-for-this-file
defmodule ExAliyunOts.TableStoreFilter.ColumnPaginationFilter do
  @moduledoc false
  defstruct offset: nil, limit: nil

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
        [] |> encode_offset(msg) |> encode_limit(msg)
      end
    )

    []

    [
      defp encode_offset(acc, msg) do
        try do
          case msg.offset do
            nil -> raise Protox.RequiredFieldsError.new([:offset])
            _ -> [acc, "\b", Protox.Encode.encode_int32(msg.offset)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:offset, "invalid field value"), __STACKTRACE__
        end
      end,
      defp encode_limit(acc, msg) do
        try do
          case msg.limit do
            nil -> raise Protox.RequiredFieldsError.new([:limit])
            _ -> [acc, "\x10", Protox.Encode.encode_int32(msg.limit)]
          end
        rescue
          ArgumentError ->
            reraise Protox.EncodingError.new(:limit, "invalid field value"), __STACKTRACE__
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
              struct(ExAliyunOts.TableStoreFilter.ColumnPaginationFilter)
            )

          case [:offset, :limit] -- set_fields do
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
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[:offset | set_fields], [offset: value], rest}

            {2, _, bytes} ->
              {value, rest} = Protox.Decode.parse_int32(bytes)
              {[:limit | set_fields], [limit: value], rest}

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
        ExAliyunOts.TableStoreFilter.ColumnPaginationFilter,
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
      %{1 => {:offset, {:scalar, 0}, :int32}, 2 => {:limit, {:scalar, 0}, :int32}}
    end

    @deprecated "Use fields_defs()/0 instead"
    @spec defs_by_name() :: %{
            required(atom) => {non_neg_integer, Protox.Types.kind(), Protox.Types.type()}
          }
    def defs_by_name() do
      %{limit: {2, {:scalar, 0}, :int32}, offset: {1, {:scalar, 0}, :int32}}
    end
  )

  (
    @spec fields_defs() :: list(Protox.Field.t())
    def fields_defs() do
      [
        %{
          __struct__: Protox.Field,
          json_name: "offset",
          kind: {:scalar, 0},
          label: :required,
          name: :offset,
          tag: 1,
          type: :int32
        },
        %{
          __struct__: Protox.Field,
          json_name: "limit",
          kind: {:scalar, 0},
          label: :required,
          name: :limit,
          tag: 2,
          type: :int32
        }
      ]
    end

    [
      @spec(field_def(atom) :: {:ok, Protox.Field.t()} | {:error, :no_such_field}),
      (
        def field_def(:offset) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "offset",
             kind: {:scalar, 0},
             label: :required,
             name: :offset,
             tag: 1,
             type: :int32
           }}
        end

        def field_def("offset") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "offset",
             kind: {:scalar, 0},
             label: :required,
             name: :offset,
             tag: 1,
             type: :int32
           }}
        end

        []
      ),
      (
        def field_def(:limit) do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "limit",
             kind: {:scalar, 0},
             label: :required,
             name: :limit,
             tag: 2,
             type: :int32
           }}
        end

        def field_def("limit") do
          {:ok,
           %{
             __struct__: Protox.Field,
             json_name: "limit",
             kind: {:scalar, 0},
             label: :required,
             name: :limit,
             tag: 2,
             type: :int32
           }}
        end

        []
      ),
      def field_def(_) do
        {:error, :no_such_field}
      end
    ]
  )

  []

  (
    @spec required_fields() :: [:offset | :limit]
    def required_fields() do
      [:offset, :limit]
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
    def default(:offset) do
      {:ok, 0}
    end,
    def default(:limit) do
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
