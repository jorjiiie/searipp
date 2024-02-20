template <typename T> T times_two(T t) {
    return t * 2;
}
template<> int times_two<int>(int t) {
    return t * 2;
}
template<> long long times_two<long long>(long long t) {
    return t * 2;
}
int main() {
    return times_two(5) + times_two(1LL);
}
