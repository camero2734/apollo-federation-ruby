# frozen_string_literal: true

require 'apollo-federation/field_set_serializer'
require 'apollo-federation/has_directives'
require 'apollo-federation/directives/key'
require 'apollo-federation/directives/extends'

module ApolloFederation
  module Object
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      include HasDirectives

      def extend_type
        directive(ApolloFederation::Directives::Extends)

        add_directive(name: 'extends')
      end

      def key(fields:)
        serialized_fields = ApolloFederation::FieldSetSerializer.serialize(fields)
        directive(ApolloFederation::Directives::Key, fields: serialized_fields)

        add_directive(
          name: 'key',
          arguments: [
            name: 'fields',
            values: serialized_fields,
          ],
        )
      end
    end
  end
end
