public extension String {
    func chunks(ofLength length: Int) -> [String] {
        assert(length > 0, "Can only chunk string into non-empty slices.")

        var chunks = [String]()
        var i = startIndex
        var remaining = count

        while i < endIndex {
            let nextI = index(i, offsetBy: min(length, remaining))
            chunks.append(String(self[i..<nextI]))
            i = nextI
            remaining -= length
        }

        return chunks
    }
}
