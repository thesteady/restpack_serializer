module RestPack
  module Serializable
    module Paging
      def page(scope, options = {})
        options.reverse_merge!(
          page: 1,
          page_size: 10,
          includes: [],
          filters: {},
          sort_by: nil,
          sort_direction: :ascending
        )

        page = scope.paginate(
          page: options[:page],
          per_page: options[:page_size]
        )

        result = {}

        result[scope.table_name.to_sym] = page
        result["#{scope.table_name}_meta".to_sym] = {
          page: options[:page],
          page_size: options[:page_size],
          count: page.total_entries,
          page_count: (page.total_entries / options[:page_size]) + 1
        }

        result
      end
    end
  end
end